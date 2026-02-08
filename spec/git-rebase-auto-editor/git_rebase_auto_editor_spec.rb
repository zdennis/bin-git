# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rebase-auto-editor" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rebase-auto-editor", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rebase-auto-editor version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rebase-auto-editor", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rebase-auto-editor", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rebase-auto-editor")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rebase-auto-editor", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains automatic rebase editor" do
      stdout, _, _ = run_bin("git-rebase-auto-editor", "--help")

      expect(stdout).to include("rebase")
      expect(stdout).to include("GIT_SEQUENCE_EDITOR")
    end
  end

  describe "editor functionality" do
    it "exits successfully when given a file" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        todo_file = File.join(tmpdir, "git-rebase-todo")
        File.write(todo_file, "pick abc1234 Initial commit\n")

        stdout, _, status = run_bin("git-rebase-auto-editor", todo_file)

        expect(status).to eq(0)
        expect(stdout).to include("Auto-rebasing")
      end
    end

    it "exits successfully without arguments (no-op)" do
      _, _, status = run_bin("git-rebase-auto-editor")

      expect(status).to eq(0)
    end
  end
end
