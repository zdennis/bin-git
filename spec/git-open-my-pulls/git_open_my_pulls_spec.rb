# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-my-pulls" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-my-pulls", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-my-pulls version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-my-pulls", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-my-pulls", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-my-pulls")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-my-pulls", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains opening your PRs on GitHub" do
      stdout, _, _ = run_bin("git-open-my-pulls", "--help")

      expect(stdout).to include("pull request")
      expect(stdout).to include("GitHub")
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
