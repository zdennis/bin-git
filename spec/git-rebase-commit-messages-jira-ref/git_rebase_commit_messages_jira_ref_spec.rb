# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rebase-commit-messages-jira-ref" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rebase-commit-messages-jira-ref", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rebase-commit-messages-jira-ref version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rebase-commit-messages-jira-ref", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rebase-commit-messages-jira-ref", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rebase-commit-messages-jira-ref")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rebase-commit-messages-jira-ref", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains JIRA reference addition" do
      stdout, _, _ = run_bin("git-rebase-commit-messages-jira-ref", "--help")

      expect(stdout).to include("JIRA")
      expect(stdout).to include("REFERENCES")
    end

    it "documents the JIRA_REF environment variable" do
      stdout, _, _ = run_bin("git-rebase-commit-messages-jira-ref", "--help")

      expect(stdout).to include("JIRA_REF")
    end
  end

  # Note: Testing actual functionality requires a git repo with commits
  # and would modify commit history, so we only test --version/--help
end
