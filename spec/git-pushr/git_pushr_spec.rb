# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-pushr" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-pushr", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-pushr version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-pushr", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-pushr", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-pushr")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-pushr", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the push and set upstream functionality" do
      stdout, _, _ = run_bin("git-pushr", "--help")

      expect(stdout).to include("upstream")
      expect(stdout).to include("origin")
    end
  end

  # Note: Can't test actual push behavior without a real remote
  # The command pushes to origin which would need network access
end
