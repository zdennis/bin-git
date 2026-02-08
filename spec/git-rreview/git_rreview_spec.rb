# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rreview" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rreview", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rreview version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rreview", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rreview", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rreview")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rreview", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains reverse review (outgoing commits)" do
      stdout, _, _ = run_bin("git-rreview", "--help")

      expect(stdout).to include("remote")
      expect(stdout).to include("local")
    end
  end

  describe "error handling" do
    it "fails when not in a git repository" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        _, stderr, status = run_bin("git-rreview", chdir: tmpdir)

        expect(status).not_to eq(0)
        expect(stderr).to include("branch")
      end
    end
  end

  # Note: Testing actual review requires repo with remote tracking branch
end
