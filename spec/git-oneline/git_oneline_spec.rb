# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-oneline" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-oneline", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-oneline version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-oneline", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-oneline", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-oneline")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-oneline", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end
  end

  describe "oneline output" do
    it "shows commits in oneline format" do
      with_test_repo do |repo|
        create_commit(repo, message: "First feature", files: { "a.txt" => "a" })
        create_commit(repo, message: "Second feature", files: { "b.txt" => "b" })

        stdout, _, status = run_bin("git-oneline", chdir: repo)

        expect(status).to eq(0)
        # Each commit should be on one line with short SHA and message
        lines = stdout.lines
        expect(lines.length).to be >= 2
        expect(lines.first).to match(/^[a-f0-9]+ .+$/)
      end
    end

    it "passes through git log options like -n" do
      with_test_repo do |repo|
        create_commit(repo, message: "Commit 1", files: { "a.txt" => "a" })
        create_commit(repo, message: "Commit 2", files: { "b.txt" => "b" })
        create_commit(repo, message: "Commit 3", files: { "c.txt" => "c" })

        stdout, _, status = run_bin("git-oneline", "-n", "2", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.lines.length).to eq(2)
      end
    end

    it "shows commits for a specific file" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add file A", files: { "a.txt" => "a" })
        create_commit(repo, message: "Add file B", files: { "b.txt" => "b" })
        create_commit(repo, message: "Update file A", files: { "a.txt" => "updated" })

        stdout, _, status = run_bin("git-oneline", "--", "a.txt", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Add file A")
        expect(stdout).to include("Update file A")
        expect(stdout).not_to include("Add file B")
      end
    end
  end
end
