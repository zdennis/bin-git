# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-stash-find" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-stash-find", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-stash-find version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-stash-find", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-stash-find", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-stash-find")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-stash-find", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "documents the -f option for filename pattern" do
      stdout, _, _ = run_bin("git-stash-find", "--help")

      expect(stdout).to include("-f")
      expect(stdout).to include("pattern")
    end

    it "documents the --after and --before options" do
      stdout, _, _ = run_bin("git-stash-find", "--help")

      expect(stdout).to include("--after")
      expect(stdout).to include("--before")
    end
  end

  describe "finding stashes" do
    it "runs with no stashes present" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-stash-find", "-f", "config", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end
  end
end
