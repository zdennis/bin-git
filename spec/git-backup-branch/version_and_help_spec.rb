# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-backup-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-backup-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-backup-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-backup-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-backup-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-backup-branch")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-backup-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "documents all major options" do
      stdout, _, _ = run_bin("git-backup-branch", "--help")

      expect(stdout).to include("--list")
      expect(stdout).to include("--restore")
      expect(stdout).to include("--delete")
      expect(stdout).to include("--tag")
      expect(stdout).to include("--remote")
      expect(stdout).to include("--diff")
      expect(stdout).to include("--quiet")
    end

    it "includes usage examples" do
      stdout, _, _ = run_bin("git-backup-branch", "--help")

      expect(stdout).to include("Examples:")
    end
  end
end
