# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rollback" do
  describe "rolling back commits" do
    it "rolls back 1 commit with changes staged" do
      with_test_repo do |repo|
        # Create a commit to roll back
        create_commit(repo, message: "Commit to roll back", files: { "new.txt" => "content" })
        original_sha = head_sha(repo)

        # Roll back
        stdout, stderr, status = run_bin("git-rollback", "1", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Rolled back")

        # HEAD should have moved back
        new_sha = head_sha(repo)
        expect(new_sha).not_to eq(original_sha)

        # Changes should be staged (soft reset)
        staged_stdout, _, _ = run_command("git diff --cached --name-only", chdir: repo)
        expect(staged_stdout).to include("new.txt")
      end
    end

    it "rolls back multiple commits" do
      with_test_repo do |repo|
        # Create commits to roll back
        create_commit(repo, message: "First", files: { "file1.txt" => "1" })
        first_sha = head_sha(repo)
        create_commit(repo, message: "Second", files: { "file2.txt" => "2" })
        create_commit(repo, message: "Third", files: { "file3.txt" => "3" })

        # Roll back 2 commits
        stdout, _, status = run_bin("git-rollback", "2", chdir: repo)

        expect(status).to eq(0)

        # HEAD should be at the first commit
        expect(head_sha(repo)).to eq(first_sha)

        # Both files should be staged
        staged_stdout, _, _ = run_command("git diff --cached --name-only", chdir: repo)
        expect(staged_stdout).to include("file2.txt")
        expect(staged_stdout).to include("file3.txt")
      end
    end

    it "preserves file contents in working directory" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add file", files: { "myfile.txt" => "my content" })

        run_bin("git-rollback", "1", chdir: repo)

        # File should still exist with same content
        content = File.read(File.join(repo, "myfile.txt"))
        expect(content).to eq("my content")
      end
    end
  end

  describe "argument validation" do
    it "requires a number argument" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-rollback", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("must specify")
      end
    end

    it "rejects non-numeric arguments" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-rollback", "abc", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("positive integer")
      end
    end

    it "rejects zero" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-rollback", "0", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("greater than 0")
      end
    end

    it "rejects negative numbers" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-rollback", "-1", chdir: repo)

        # -1 looks like a flag to the case statement, but isn't recognized
        # It should fail (not perform any rollback)
        expect(status).not_to eq(0)
      end
    end
  end
end
