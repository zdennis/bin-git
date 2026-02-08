# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-find-pr-for-sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-find-pr-for-sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-find-pr-for-sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-find-pr-for-sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-find-pr-for-sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-find-pr-for-sha")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-find-pr-for-sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains finding pull requests for commits" do
      stdout, _, _ = run_bin("git-find-pr-for-sha", "--help")

      expect(stdout).to include("pull request")
      expect(stdout).to include("SHA")
    end
  end

  describe "error handling" do
    it "fails when no SHA is provided" do
      _, stderr, status = run_bin("git-find-pr-for-sha")

      expect(status).not_to eq(0)
      expect(stderr).to include("SHA")
    end

    it "fails when not in a git repository" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        _, stderr, status = run_bin("git-find-pr-for-sha", "abc1234", chdir: tmpdir)

        expect(status).not_to eq(0)
        expect(stderr).to include("git repository")
      end
    end
  end

  # Note: Testing actual PR finding requires real GitHub repo history
end
