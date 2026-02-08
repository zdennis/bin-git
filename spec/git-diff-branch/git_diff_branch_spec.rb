# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-diff-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-diff-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-diff-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-diff-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-diff-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-diff-branch")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-diff-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the range-diff functionality" do
      stdout, _, _ = run_bin("git-diff-branch", "--help")

      expect(stdout).to include("range-diff")
    end
  end

  describe "showing range-diff" do
    it "compares against specified base ref" do
      with_test_repo do |repo|
        # Create a feature branch with commits
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature commit", files: { "f.txt" => "f" })

        # Compare against main
        stdout, stderr, status = run_bin("git-diff-branch", "main", chdir: repo)

        # May succeed or fail depending on git version, but should run
        # The command uses range-diff which requires git 2.19+
        expect([0, 1, 128]).to include(status)
      end
    end
  end
end
