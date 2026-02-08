# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-fixup" do
  describe "creating fixup commits" do
    it "creates a fixup commit for the specified SHA" do
      with_test_repo do |repo|
        # Create a commit to fix up
        create_commit(repo, message: "Original commit", files: { "file.txt" => "v1" })
        target_sha = head_sha(repo, short: true)

        # Stage changes to fixup
        File.write(File.join(repo, "file.txt"), "v2")
        run_command("git add file.txt", chdir: repo)

        # Create fixup commit
        stdout, stderr, status = run_bin("git-fixup", target_sha, chdir: repo)

        expect(status).to eq(0)

        # Check the commit message format
        msg_stdout, _, _ = run_command("git log -1 --format=%s", chdir: repo)
        expect(msg_stdout).to include("fixup!")
        expect(msg_stdout).to include("Original commit")
      end
    end

    it "accepts full SHA" do
      with_test_repo do |repo|
        create_commit(repo, message: "Target commit", files: { "a.txt" => "a" })
        full_sha = head_sha(repo, short: false)

        File.write(File.join(repo, "a.txt"), "updated")
        run_command("git add a.txt", chdir: repo)

        stdout, stderr, status = run_bin("git-fixup", full_sha, chdir: repo)

        expect(status).to eq(0)

        msg, _, _ = run_command("git log -1 --format=%s", chdir: repo)
        expect(msg).to include("fixup!")
      end
    end

    it "accepts short SHA" do
      with_test_repo do |repo|
        create_commit(repo, message: "Target commit", files: { "b.txt" => "b" })
        short_sha = head_sha(repo, short: true)

        File.write(File.join(repo, "b.txt"), "updated")
        run_command("git add b.txt", chdir: repo)

        stdout, stderr, status = run_bin("git-fixup", short_sha, chdir: repo)

        expect(status).to eq(0)

        msg, _, _ = run_command("git log -1 --format=%s", chdir: repo)
        expect(msg).to include("fixup!")
      end
    end
  end

  describe "argument validation" do
    it "requires a SHA argument" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-fixup", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
        expect(stderr).to include("SHA")
      end
    end

    it "validates that the SHA exists" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-fixup", "nonexistent123", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
        expect(stderr).to include("Invalid")
      end
    end
  end

  describe "error conditions" do
    it "fails when there are no staged changes" do
      with_test_repo do |repo|
        create_commit(repo, message: "Target", files: { "file.txt" => "content" })
        sha = head_sha(repo, short: true)

        # No staged changes
        stdout, stderr, status = run_bin("git-fixup", sha, chdir: repo)

        # Git commit will fail with nothing to commit
        expect(status).not_to eq(0)
      end
    end
  end
end
