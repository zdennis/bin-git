# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-edit-sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-edit-sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-edit-sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-edit-sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-edit-sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-edit-sha")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-edit-sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the edit commit functionality" do
      stdout, _, _ = run_bin("git-edit-sha", "--help")

      expect(stdout).to include("edit")
      expect(stdout).to include("SHA")
    end

    it "shows examples" do
      stdout, _, _ = run_bin("git-edit-sha", "--help")

      expect(stdout).to include("abc1234")
    end
  end

  # Note: Can't test actual rebase behavior in automated tests
  # as git rebase is interactive
end
