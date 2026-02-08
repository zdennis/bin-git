# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-new-repos" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-new-repos", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-new-repos version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-new-repos", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-new-repos", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-new-repos")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-new-repos", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains opening GitHub new repository page" do
      stdout, _, _ = run_bin("git-new-repos", "--help")

      expect(stdout).to include("GitHub")
      expect(stdout).to include("new repository")
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
