# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-github-project" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-github-project", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-github-project version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-github-project", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-github-project", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-github-project")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-github-project", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains opening GitHub projects" do
      stdout, _, _ = run_bin("git-open-github-project", "--help")

      expect(stdout).to include("GitHub")
      expect(stdout).to include("organization/repository")
    end
  end

  describe "error handling" do
    it "fails when no project is provided" do
      _, stderr, status = run_bin("git-open-github-project")

      expect(status).not_to eq(0)
      expect(stderr).to include("github project")
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
