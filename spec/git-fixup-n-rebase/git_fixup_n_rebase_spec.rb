# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-fixup-n-rebase" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-fixup-n-rebase", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-fixup-n-rebase version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-fixup-n-rebase", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-fixup-n-rebase", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-fixup-n-rebase")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-fixup-n-rebase", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the fixup and rebase functionality" do
      stdout, _, _ = run_bin("git-fixup-n-rebase", "--help")

      expect(stdout).to include("fixup")
      expect(stdout).to include("rebase")
    end
  end

  describe "error handling" do
    it "fails when no SHA is provided" do
      stdout, stderr, status = run_bin("git-fixup-n-rebase")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("SHA")
    end
  end

  # Note: Can't test actual fixup and rebase behavior in automated tests
  # as git rebase is interactive
end
