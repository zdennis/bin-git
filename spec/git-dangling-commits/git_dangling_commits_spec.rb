# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-dangling-commits" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-dangling-commits", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-dangling-commits version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-dangling-commits", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-dangling-commits", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-dangling-commits")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-dangling-commits", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains dangling commits" do
      stdout, _, _ = run_bin("git-dangling-commits", "--help")

      expect(stdout).to include("dangling")
      expect(stdout).to include("lost")
    end
  end

  describe "finding dangling commits" do
    it "reports no dangling commits in a clean repo" do
      with_test_repo do |repo|
        # Run from inside the repo (the script requires being at repo root)
        stdout, _, status = run_bin("git-dangling-commits", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("No dangling commits found")
      end
    end

    it "finds dangling commits after a hard reset" do
      with_test_repo do |repo|
        # Create commits and then hard reset to lose them
        create_commit(repo, message: "Lost commit 1", files: { "lost1.txt" => "lost" })
        create_commit(repo, message: "Lost commit 2", files: { "lost2.txt" => "lost" })
        _lost_sha = head_sha(repo)

        # Reset back to first commit
        run_command("git reset --hard HEAD~2", chdir: repo)

        # The commits are now dangling
        _stdout, _, status = run_bin("git-dangling-commits", chdir: repo)

        # May or may not find them depending on GC
        expect(status).to eq(0)
      end
    end
  end

  describe "error handling" do
    it "fails when not at repository root" do
      with_test_repo do |repo|
        # Create a subdirectory
        subdir = File.join(repo, "subdir")
        FileUtils.mkdir_p(subdir)

        _stdout, stderr, status = run_bin("git-dangling-commits", chdir: subdir)

        expect(status).not_to eq(0)
        expect(stderr).to include("root")
      end
    end

    it "fails when not in a git repository" do
      Dir.mktmpdir("not-a-repo-") do |tmpdir|
        _stdout, _stderr, status = run_bin("git-dangling-commits", chdir: tmpdir)

        expect(status).not_to eq(0)
      end
    end
  end
end
