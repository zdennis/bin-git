# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-author-stats" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-author-stats", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-author-stats version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-author-stats", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-author-stats", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-author-stats")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-author-stats", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the author stats functionality" do
      stdout, _, _ = run_bin("git-author-stats", "--help")

      expect(stdout).to include("author")
      expect(stdout).to include("stats")
    end
  end

  describe "error handling" do
    it "fails when no path is provided" do
      stdout, stderr, status = run_bin("git-author-stats")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("path")
    end
  end

  describe "showing stats" do
    it "shows author stats for a file" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add code", files: { "code.rb" => "code" })

        stdout, _, status = run_bin("git-author-stats", "code.rb", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Author stats for code.rb")
        expect(stdout).to include("Test User")
      end
    end

    it "shows stats for multiple paths" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add files", files: {
          "file1.rb" => "1",
          "file2.rb" => "2"
        })

        stdout, _, status = run_bin("git-author-stats", "file1.rb", "file2.rb", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Author stats for file1.rb")
        expect(stdout).to include("Author stats for file2.rb")
      end
    end

    it "shows commit count for authors" do
      with_test_repo do |repo|
        create_commit(repo, message: "Commit 1", files: { "file.rb" => "v1" })
        create_commit(repo, message: "Commit 2", files: { "file.rb" => "v2" })

        stdout, _, status = run_bin("git-author-stats", "file.rb", chdir: repo)

        expect(status).to eq(0)
        # Should show count (at least 2 commits by Test User)
        expect(stdout).to match(/\d+\s+Test User/)
      end
    end
  end
end
