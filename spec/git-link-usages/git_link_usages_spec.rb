# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-link-usages" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-link-usages", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-link-usages version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-link-usages", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-link-usages", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-link-usages")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-link-usages", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains generating markdown links" do
      stdout, _, _ = run_bin("git-link-usages", "--help")

      expect(stdout).to include("markdown")
      expect(stdout).to include("GitHub")
    end
  end

  describe "error handling" do
    it "fails when no pattern is provided" do
      _, stderr, status = run_bin("git-link-usages")

      expect(status).not_to eq(0)
      expect(stderr).to include("pattern")
    end
  end

  # Note: Testing actual link generation requires a repo with origin remote
end
