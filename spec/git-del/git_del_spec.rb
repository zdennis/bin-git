# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-del" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-del", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-del version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-del", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-del", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-del")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-del", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the deleted files functionality" do
      stdout, _, _ = run_bin("git-del", "--help")

      expect(stdout).to include("deleted")
      expect(stdout).to include("Stage")
    end
  end

  describe "staging deleted files" do
    it "reports no deleted files when none exist" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-del", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("No deleted files")
      end
    end

    it "stages deleted files for commit" do
      with_test_repo do |repo|
        # Create and commit a file
        create_commit(repo, message: "Add file", files: { "to_delete.txt" => "content" })

        # Delete the file (but don't git rm it)
        FileUtils.rm(File.join(repo, "to_delete.txt"))

        # Run git-del to stage the deletion
        stdout, _, status = run_bin("git-del", chdir: repo)

        expect(status).to eq(0)

        # Verify file is staged for deletion
        git_status, _, _ = run_command("git status --porcelain", chdir: repo)
        expect(git_status).to include("D")
        expect(git_status).to include("to_delete.txt")
      end
    end

    it "stages multiple deleted files" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add files", files: {
          "file1.txt" => "1",
          "file2.txt" => "2",
          "file3.txt" => "3"
        })

        # Delete two files
        FileUtils.rm(File.join(repo, "file1.txt"))
        FileUtils.rm(File.join(repo, "file3.txt"))

        stdout, _, status = run_bin("git-del", chdir: repo)

        expect(status).to eq(0)

        # Verify both are staged
        git_status, _, _ = run_command("git status --porcelain", chdir: repo)
        expect(git_status).to include("file1.txt")
        expect(git_status).to include("file3.txt")
      end
    end
  end
end
