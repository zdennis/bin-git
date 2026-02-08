# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-copy-sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-copy-sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-copy-sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-copy-sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-copy-sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-copy-sha")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-copy-sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "documents the -n option" do
      stdout, _, _ = run_bin("git-copy-sha", "--help")

      expect(stdout).to include("-n")
      expect(stdout).to include("characters")
    end

    it "documents the --short option" do
      stdout, _, _ = run_bin("git-copy-sha", "--help")

      expect(stdout).to include("-s")
      expect(stdout).to include("short")
    end

    it "documents the --gcb-short option" do
      stdout, _, _ = run_bin("git-copy-sha", "--help")

      expect(stdout).to include("--gcb-short")
    end
  end

  describe "copying SHAs" do
    # Note: These tests verify the command runs successfully
    # but cannot test clipboard contents without pbpaste

    it "copies current commit SHA" do
      with_test_repo do |repo|
        _, _, status = run_bin("git-copy-sha", chdir: repo)

        expect(status).to eq(0)
      end
    end

    it "accepts -s flag for short SHA" do
      with_test_repo do |repo|
        _, _, status = run_bin("git-copy-sha", "-s", chdir: repo)

        expect(status).to eq(0)
      end
    end

    it "accepts --gcb-short for 7-char SHA" do
      with_test_repo do |repo|
        _, _, status = run_bin("git-copy-sha", "--gcb-short", chdir: repo)

        expect(status).to eq(0)
      end
    end

    it "accepts -n option for custom length" do
      with_test_repo do |repo|
        _, _, status = run_bin("git-copy-sha", "-n=10", chdir: repo)

        expect(status).to eq(0)
      end
    end
  end
end
