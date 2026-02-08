# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rebase-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rebase-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rebase-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rebase-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rebase-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rebase-branch")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rebase-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the rebase functionality" do
      stdout, _, _ = run_bin("git-rebase-branch", "--help")

      expect(stdout).to include("Rebase")
      expect(stdout).to include("diverge")
    end

    it "documents the -i option for interactive rebase" do
      stdout, _, _ = run_bin("git-rebase-branch", "--help")

      expect(stdout).to include("-i")
      expect(stdout).to include("interactive")
    end
  end

  # Note: Can't easily test actual rebase behavior in automated tests
  # as git rebase -i requires an editor and is interactive
end
