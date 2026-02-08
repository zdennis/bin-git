# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-1" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-1", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-1 version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-1", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-1", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-1")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-1", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the oneline format" do
      stdout, _, _ = run_bin("git-1", "--help")

      expect(stdout).to include("oneline")
    end

    it "documents the --author option" do
      stdout, _, _ = run_bin("git-1", "--help")

      expect(stdout).to include("--author")
    end
  end

  describe "showing commits" do
    it "shows commits on the current branch vs main" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature commit 1", files: { "f1.txt" => "1" })
        create_commit(repo, message: "Feature commit 2", files: { "f2.txt" => "2" })

        stdout, _, status = run_bin("git-1", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Feature commit 1")
        expect(stdout).to include("Feature commit 2")
      end
    end

    it "shows commits with author when --author is specified" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Author test commit", files: { "test.txt" => "test" })

        stdout, _, status = run_bin("git-1", "--author", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Test User")
      end
    end

    it "accepts -a as shorthand for --author" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Short author test", files: { "test.txt" => "test" })

        stdout, _, status = run_bin("git-1", "-a", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Test User")
      end
    end

    it "shows empty output when on main with no new commits" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-1", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end

    it "accepts HEAD~N format" do
      with_test_repo do |repo|
        create_commit(repo, message: "Commit A", files: { "a.txt" => "a" })
        create_commit(repo, message: "Commit B", files: { "b.txt" => "b" })
        create_commit(repo, message: "Commit C", files: { "c.txt" => "c" })

        stdout, _, status = run_bin("git-1", "HEAD~2", chdir: repo)

        expect(status).to eq(0)
        # Should show recent commits
        expect(stdout).to include("Commit")
      end
    end
  end
end
