# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-get-main-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-get-main-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-get-main-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-get-main-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-get-main-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-get-main-branch")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-get-main-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the branch detection logic" do
      stdout, _, _ = run_bin("git-get-main-branch", "--help")

      expect(stdout).to include("main")
      expect(stdout).to include("master")
    end

    it "documents exit codes" do
      stdout, _, _ = run_bin("git-get-main-branch", "--help")

      expect(stdout).to include("Exit codes:")
    end
  end
end
