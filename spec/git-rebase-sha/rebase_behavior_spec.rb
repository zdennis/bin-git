# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rebase-sha" do
  describe "rebasing from SHA" do
    it "performs an autosquash rebase from the specified SHA" do
      with_test_repo do |repo|
        # Create commits
        create_commit(repo, message: "First commit", files: { "a.txt" => "a" })
        target_sha = head_sha(repo, short: true)
        create_commit(repo, message: "Second commit", files: { "b.txt" => "b" })

        # Create a fixup commit for the first commit
        File.write(File.join(repo, "a.txt"), "a updated")
        run_command("git add a.txt", chdir: repo)
        run_command("git commit --fixup=#{target_sha}", chdir: repo)

        initial_count, _, _ = run_command("git rev-list --count HEAD", chdir: repo)

        # Run rebase-sha to autosquash
        stdout, _stderr, status = run_bin("git-rebase-sha", target_sha, chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Done!")

        # Fixup should have been squashed (one less commit)
        final_count, _, _ = run_command("git rev-list --count HEAD", chdir: repo)
        expect(final_count.strip.to_i).to eq(initial_count.strip.to_i - 1)
      end
    end

    it "accepts full SHA" do
      with_test_repo do |repo|
        create_commit(repo, message: "Target", files: { "file.txt" => "content" })
        full_sha = head_sha(repo, short: false)
        create_commit(repo, message: "After", files: { "file2.txt" => "content" })

        _stdout, _stderr, status = run_bin("git-rebase-sha", full_sha, chdir: repo)

        expect(status).to eq(0)
      end
    end

    it "accepts short SHA" do
      with_test_repo do |repo|
        create_commit(repo, message: "Target", files: { "file.txt" => "content" })
        short_sha = head_sha(repo, short: true)
        create_commit(repo, message: "After", files: { "file2.txt" => "content" })

        _stdout, _stderr, status = run_bin("git-rebase-sha", short_sha, chdir: repo)

        expect(status).to eq(0)
      end
    end
  end

  describe "argument validation" do
    it "requires a SHA argument" do
      with_test_repo do |repo|
        _stdout, stderr, status = run_bin("git-rebase-sha", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("SHA")
      end
    end

    it "validates that the SHA exists" do
      with_test_repo do |repo|
        _stdout, stderr, status = run_bin("git-rebase-sha", "nonexistent123", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Invalid")
      end
    end
  end
end
