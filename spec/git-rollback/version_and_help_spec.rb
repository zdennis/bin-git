# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rollback" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rollback", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rollback version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rollback", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rollback", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rollback")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rollback", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the soft reset behavior" do
      stdout, _, _ = run_bin("git-rollback", "--help")

      expect(stdout).to include("soft reset")
    end

    it "includes usage examples" do
      stdout, _, _ = run_bin("git-rollback", "--help")

      expect(stdout).to include("Examples:")
    end
  end
end
