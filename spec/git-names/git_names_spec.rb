# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-names" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-names", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-names version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-names", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-names", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-names")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-names", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the filename listing functionality" do
      stdout, _, _ = run_bin("git-names", "--help")

      expect(stdout).to include("filename")
    end
  end

  describe "showing changed files" do
    it "shows files changed between branch and main" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Add feature", files: { "feature.rb" => "code" })

        stdout, _, status = run_bin("git-names", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("feature.rb")
      end
    end

    it "shows file status (Added/Modified/Deleted)" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Add new file", files: { "new_file.rb" => "new" })

        stdout, _, status = run_bin("git-names", chdir: repo)

        expect(status).to eq(0)
        # Should show status like A (added), M (modified), D (deleted)
        expect(stdout).to match(/[AMD]\s+/)
      end
    end

    it "accepts commit range argument" do
      with_test_repo do |repo|
        create_commit(repo, message: "Commit 1", files: { "file1.rb" => "1" })
        create_commit(repo, message: "Commit 2", files: { "file2.rb" => "2" })

        _stdout, _, status = run_bin("git-names", "HEAD~1", chdir: repo)

        expect(status).to eq(0)
      end
    end
  end
end
