# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-my-prs" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-my-prs", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-my-prs version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-my-prs", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-my-prs", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-my-prs")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-my-prs", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains listing your PRs" do
      stdout, _, _ = run_bin("git-my-prs", "--help")

      expect(stdout).to include("pull request")
    end

    it "documents the github.user setup" do
      stdout, _, _ = run_bin("git-my-prs", "--help")

      expect(stdout).to include("github.user")
    end
  end

  # Note: Can't test actual gh CLI integration without GitHub auth
end
