# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-1sha" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-1sha", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-1sha version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-1sha", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-1sha", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-1sha")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-1sha", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the SHA output" do
      stdout, _, _ = run_bin("git-1sha", "--help")

      expect(stdout).to include("SHA")
    end
  end

  describe "printing SHAs" do
    it "prints short SHAs of commits since main branch" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature 1", files: { "f1.txt" => "1" })
        create_commit(repo, message: "Feature 2", files: { "f2.txt" => "2" })

        stdout, _, status = run_bin("git-1sha", chdir: repo)

        expect(status).to eq(0)
        lines = stdout.lines.map(&:strip).reject(&:empty?)
        expect(lines.length).to eq(2)
        # Short SHAs are typically 7 characters
        expect(lines.first).to match(/^[a-f0-9]{7,}$/)
      end
    end

    it "shows empty output when on main with no new commits" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-1sha", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end

    it "accepts a ref argument" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Commit", files: { "c.txt" => "c" })

        stdout, _, status = run_bin("git-1sha", "HEAD", chdir: repo)

        expect(status).to eq(0)
        lines = stdout.lines.map(&:strip).reject(&:empty?)
        expect(lines.length).to eq(1)
      end
    end
  end
end
