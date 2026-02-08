# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-url" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-url", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-url version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-url", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-url", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-url")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-url", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains opening repository URL" do
      stdout, _, _ = run_bin("git-open-url", "--help")

      expect(stdout).to include("repository")
      expect(stdout).to include("browser")
    end
  end

  describe "error handling" do
    it "fails when no origin remote exists" do
      with_test_repo do |repo|
        _, stderr, status = run_bin("git-open-url", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
