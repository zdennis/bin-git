# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-find-merge-with-sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-find-merge-with-sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-find-merge-with-sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-find-merge-with-sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-find-merge-with-sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-find-merge-with-sha")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-find-merge-with-sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains finding merge commits" do
      stdout, _, _ = run_bin("git-find-merge-with-sha", "--help")

      expect(stdout).to include("merge")
      expect(stdout).to include("SHA")
    end
  end

  describe "error handling" do
    it "fails when no SHA is provided" do
      _, stderr, status = run_bin("git-find-merge-with-sha")

      expect(status).not_to eq(0)
      expect(stderr).to include("SHA")
    end
  end

  # Note: Testing actual merge finding requires complex repo history
end
