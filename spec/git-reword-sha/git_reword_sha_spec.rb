# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-reword-sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-reword-sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-reword-sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-reword-sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-reword-sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-reword-sha")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-reword-sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains rewording commits" do
      stdout, _, _ = run_bin("git-reword-sha", "--help")

      expect(stdout).to include("reword")
      expect(stdout).to include("commit")
    end
  end

  describe "error handling" do
    it "fails when no SHA is provided" do
      stdout, stderr, status = run_bin("git-reword-sha")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("SHA")
    end
  end

  # Note: Can't test actual rebase behavior in automated tests
end
