# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-prs-waiting-for-my-review" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-prs-waiting-for-my-review", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-prs-waiting-for-my-review version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-prs-waiting-for-my-review", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-prs-waiting-for-my-review", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-prs-waiting-for-my-review")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-prs-waiting-for-my-review", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains listing PRs waiting for review" do
      stdout, _, _ = run_bin("git-prs-waiting-for-my-review", "--help")

      expect(stdout).to include("review")
      expect(stdout).to include("GitHub")
    end
  end

  # Note: Testing actual PR search requires GitHub CLI authentication
end
