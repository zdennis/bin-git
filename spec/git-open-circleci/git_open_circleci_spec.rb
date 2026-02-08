# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-circleci" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-circleci", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-circleci version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-circleci", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-circleci", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-circleci")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-circleci", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains opening CircleCI builds" do
      stdout, _, _ = run_bin("git-open-circleci", "--help")

      expect(stdout).to include("CircleCI")
      expect(stdout).to include("branch")
    end
  end

  describe "error handling" do
    it "fails when not in a git repository" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        _, stderr, status = run_bin("git-open-circleci", chdir: tmpdir)

        expect(status).not_to eq(0)
        expect(stderr).to include("repository")
      end
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
