# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rebase-sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rebase-sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rebase-sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rebase-sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rebase-sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rebase-sha")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rebase-sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the rebase workflow" do
      stdout, _, _ = run_bin("git-rebase-sha", "--help")

      expect(stdout).to include("rebase")
      expect(stdout).to include("commit")
    end

    it "includes usage examples" do
      stdout, _, _ = run_bin("git-rebase-sha", "--help")

      expect(stdout).to include("Examples:")
    end
  end
end
