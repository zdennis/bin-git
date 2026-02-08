# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-pull" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-pull", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-pull version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-pull", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-pull", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-pull")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-pull", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the pull request functionality" do
      stdout, _, _ = run_bin("git-open-pull", "--help")

      expect(stdout).to include("pull request")
    end

    it "shows examples" do
      stdout, _, _ = run_bin("git-open-pull", "--help")

      expect(stdout).to include("123")
      expect(stdout).to include("SHA")
    end
  end

  # Note: Can't test actual PR opening/creating without gh CLI and GitHub auth
  # The command requires gh to be installed and authenticated
end
