# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-squash-all-commits" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-squash-all-commits", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-squash-all-commits version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-squash-all-commits", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-squash-all-commits", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-squash-all-commits")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-squash-all-commits", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the squash behavior" do
      stdout, _, _ = run_bin("git-squash-all-commits", "--help")

      expect(stdout).to include("Squash")
      expect(stdout).to include("single commit")
    end

    it "includes usage examples" do
      stdout, _, _ = run_bin("git-squash-all-commits", "--help")

      expect(stdout).to include("Examples:")
    end
  end
end
