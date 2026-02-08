# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rebase-rubocop" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rebase-rubocop", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rebase-rubocop version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rebase-rubocop", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rebase-rubocop", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rebase-rubocop")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rebase-rubocop", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains rubocop autocorrect during rebase" do
      stdout, _, _ = run_bin("git-rebase-rubocop", "--help")

      expect(stdout).to include("rubocop")
      expect(stdout).to include("autocorrect")
    end
  end

  # Note: Testing actual functionality requires cf, rt commands and Ruby files
end
