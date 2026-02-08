# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-find-prs-for-file" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-find-prs-for-file", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-find-prs-for-file version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-find-prs-for-file", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-find-prs-for-file", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-find-prs-for-file")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-find-prs-for-file", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains finding PRs that modified a file" do
      stdout, _, _ = run_bin("git-find-prs-for-file", "--help")

      expect(stdout).to include("pull request")
      expect(stdout).to include("file")
    end
  end

  describe "error handling" do
    it "fails when no file is provided" do
      _, stderr, status = run_bin("git-find-prs-for-file")

      expect(status).not_to eq(0)
      expect(stderr).to include("file")
    end
  end

  # Note: Testing actual PR lookup requires GitHub CLI authentication
end
