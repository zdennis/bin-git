# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-bin-git-path" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-bin-git-path", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-bin-git-path version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-bin-git-path", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-bin-git-path", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-bin-git-path")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-bin-git-path", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains it returns bin directory path" do
      stdout, _, _ = run_bin("git-bin-git-path", "--help")

      expect(stdout).to include("path")
      expect(stdout).to include("directory")
    end
  end

  describe "printing the path" do
    it "returns the bin directory path" do
      stdout, _, status = run_bin("git-bin-git-path")

      expect(status).to eq(0)
      expect(stdout.strip).to end_with("/bin")
    end

    it "returns an absolute path" do
      stdout, _, status = run_bin("git-bin-git-path")

      expect(status).to eq(0)
      expect(stdout.strip).to start_with("/")
    end

    it "returns a path that exists" do
      stdout, _, status = run_bin("git-bin-git-path")

      expect(status).to eq(0)
      expect(Dir.exist?(stdout.strip)).to be true
    end
  end
end
