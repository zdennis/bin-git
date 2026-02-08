# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-amend" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-amend", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-amend version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, stderr, status = run_bin("git-amend", "-v")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-amend version \d+\.\d+\.\d+/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-amend", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-amend")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
      expect(stdout).to include("--help")
      expect(stdout).to include("--version")
    end

    it "accepts -h as shorthand" do
      stdout, stderr, status = run_bin("git-amend", "-h")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("Usage:")
    end

    it "includes usage examples" do
      stdout, _, _ = run_bin("git-amend", "--help")

      expect(stdout).to include("Examples:")
      expect(stdout).to include("git-amend")
    end
  end
end
