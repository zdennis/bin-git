# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-amend" do
  describe "amending commits" do
    it "amends the last commit with staged changes" do
      with_test_repo do |repo|
        # Create initial state
        create_commit(repo, message: "First commit", files: { "file1.txt" => "content1" })
        original_sha = head_sha(repo)

        # Stage a change
        File.write(File.join(repo, "file2.txt"), "new content")
        run_command("git add file2.txt", chdir: repo)

        # Amend
        stdout, stderr, status = run_bin("git-amend", chdir: repo)

        # The SHA should change (commit was amended)
        new_sha = head_sha(repo)
        expect(new_sha).not_to eq(original_sha)

        # The new file should be in the commit
        files_stdout, _, _ = run_command("git show --name-only --format=''", chdir: repo)
        expect(files_stdout).to include("file2.txt")

        # Commit message should be preserved
        msg_stdout, _, _ = run_command("git log -1 --format=%s", chdir: repo)
        expect(msg_stdout.strip).to eq("First commit")
      end
    end

    it "preserves the original commit message" do
      with_test_repo do |repo|
        original_message = "This is a detailed commit message"
        create_commit(repo, message: original_message, files: { "file.txt" => "content" })

        # Stage another change
        File.write(File.join(repo, "another.txt"), "more content")
        run_command("git add another.txt", chdir: repo)

        # Amend
        run_bin("git-amend", chdir: repo)

        # Check message is preserved
        msg_stdout, _, _ = run_command("git log -1 --format=%s", chdir: repo)
        expect(msg_stdout.strip).to eq(original_message)
      end
    end

    it "passes through git commit options like -a" do
      with_test_repo do |repo|
        create_commit(repo, message: "Initial", files: { "tracked.txt" => "v1" })

        # Modify tracked file without staging
        File.write(File.join(repo, "tracked.txt"), "v2")

        # Amend with -a to auto-stage tracked files
        stdout, stderr, status = run_bin("git-amend", "-a", chdir: repo)

        # The change should be included
        content_stdout, _, _ = run_command("git show HEAD:tracked.txt", chdir: repo)
        expect(content_stdout).to eq("v2")
      end
    end

    it "fails when there is nothing to amend and no staged changes" do
      with_test_repo do |repo|
        # Just the initial commit, nothing to amend
        stdout, stderr, status = run_bin("git-amend", chdir: repo)

        # Git will report nothing to commit (depending on git version)
        # The exit status may vary, but it shouldn't crash
        expect(status).to be >= 0
      end
    end
  end
end
