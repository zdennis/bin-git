# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-ignore-files-for-grep" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-ignore-files-for-grep", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-ignore-files-for-grep version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-ignore-files-for-grep", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-ignore-files-for-grep", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-ignore-files-for-grep")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-ignore-files-for-grep", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the grep exclude functionality" do
      stdout, _, _ = run_bin("git-ignore-files-for-grep", "--help")

      expect(stdout).to include("grep")
      expect(stdout).to include("exclude")
    end
  end

  describe "generating exclude flags" do
    it "returns empty when no .gitignore exists" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        stdout, _, status = run_bin("git-ignore-files-for-grep", chdir: tmpdir)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end

    it "generates exclude flags from .gitignore" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        File.write(File.join(tmpdir, ".gitignore"), "*.log\n*.tmp\n.env\n")

        stdout, _, status = run_bin("git-ignore-files-for-grep", chdir: tmpdir)

        expect(status).to eq(0)
        expect(stdout).to include("--exclude")
        expect(stdout).to include("*.log")
        expect(stdout).to include("*.tmp")
      end
    end
  end
end
