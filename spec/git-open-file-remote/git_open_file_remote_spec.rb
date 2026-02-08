# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-open-file-remote" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-open-file-remote", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-open-file-remote version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-open-file-remote", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-open-file-remote", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-open-file-remote")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-open-file-remote", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains opening files on GitHub" do
      stdout, _, _ = run_bin("git-open-file-remote", "--help")

      expect(stdout).to include("file")
      expect(stdout).to include("GitHub")
    end

    it "documents the -m flag for main branch" do
      stdout, _, _ = run_bin("git-open-file-remote", "--help")

      expect(stdout).to include("-m")
      expect(stdout).to include("main")
    end
  end

  describe "error handling" do
    it "fails when no file path is provided" do
      _, stderr, status = run_bin("git-open-file-remote")

      expect(status).not_to eq(0)
      expect(stderr).to include("path")
    end
  end

  # Note: Can't test actual browser opening in automated tests
end
