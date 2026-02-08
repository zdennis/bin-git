# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-clone-github" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-clone-github", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-clone-github version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-clone-github", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-clone-github", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-clone-github")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-clone-github", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains GitHub repository cloning" do
      stdout, _, _ = run_bin("git-clone-github", "--help")

      expect(stdout).to include("Clone")
      expect(stdout).to include("GitHub")
      expect(stdout).to include("organization/repository")
    end
  end

  describe "error handling" do
    it "fails when no project is provided" do
      _, stderr, status = run_bin("git-clone-github")

      expect(status).not_to eq(0)
      expect(stderr).to include("github project")
    end
  end

  # Note: Can't test actual cloning in automated tests (network + side effects)
end
