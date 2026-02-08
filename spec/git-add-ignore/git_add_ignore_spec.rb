# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-add-ignore" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-add-ignore", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-add-ignore version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-add-ignore", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-add-ignore", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-add-ignore")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-add-ignore", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the gitignore template functionality" do
      stdout, _, _ = run_bin("git-add-ignore", "--help")

      expect(stdout).to include("gitignore")
      expect(stdout).to include("GitHub")
    end

    it "shows example languages" do
      stdout, _, _ = run_bin("git-add-ignore", "--help")

      expect(stdout).to include("Ruby")
      expect(stdout).to include("Python")
    end
  end

  describe "error handling" do
    it "fails when no language is provided" do
      stdout, stderr, status = run_bin("git-add-ignore")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("language")
    end

    it "shows usage hint when no language provided" do
      _, stderr, _ = run_bin("git-add-ignore")

      expect(stderr).to include("Usage:")
    end
  end

  # Note: Network-dependent tests are skipped to avoid flaky tests
  # The script downloads from https://raw.github.com/github/gitignore/master/
  describe "downloading templates", skip: "Requires network access" do
    it "downloads and appends Ruby gitignore" do
      Dir.mktmpdir("git-add-ignore-test-") do |tmpdir|
        Dir.chdir(tmpdir) do
          stdout, _, status = run_bin("git-add-ignore", "Ruby")

          expect(status).to eq(0)
          expect(stdout).to include("Ruby")
          expect(File.exist?(".gitignore")).to be true
        end
      end
    end
  end
end
