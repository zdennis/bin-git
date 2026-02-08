# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-current-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-current-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-current-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, stderr, status = run_bin("git-current-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-current-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-current-branch")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
    end

    it "accepts -h as shorthand" do
      stdout, stderr, status = run_bin("git-current-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "includes description of output format" do
      stdout, _, _ = run_bin("git-current-branch", "--help")

      expect(stdout).to include("without a trailing newline")
    end
  end
end
