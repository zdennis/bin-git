# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-files" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-files", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-files version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-files", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-files", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-files")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-files", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the file pattern functionality" do
      stdout, _, _ = run_bin("git-open-files", "--help")

      expect(stdout).to include("pattern")
      expect(stdout).to include("GitHub")
    end
  end

  describe "error handling" do
    it "fails when no pattern is provided" do
      stdout, stderr, status = run_bin("git-open-files")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("pattern")
    end

    it "fails when no origin remote exists" do
      with_test_repo do |repo|
        _, stderr, status = run_bin("git-open-files", "test", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
