# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-backup-branch" do
  describe "listing backups" do
    it "lists backup branches for current branch with -l" do
      with_test_repo do |repo|
        # Create some backups
        run_bin("git-backup-branch", chdir: repo)
        run_bin("git-backup-branch", "-t", "tagged", chdir: repo)

        stdout, stderr, status = run_bin("git-backup-branch", "-l", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to match(/main\.bak\.\d{4}/)
        expect(stdout).to include(".tagged")
      end
    end

    it "lists backups for a specified branch" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        run_bin("git-backup-branch", "feature", chdir: repo)
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-backup-branch", "-l", "feature", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to match(/feature\.bak/)
      end
    end

    it "shows commit counts with verbose listing" do
      with_test_repo do |repo|
        create_commit(repo, message: "Commit 1", files: { "a.txt" => "a" })
        create_commit(repo, message: "Commit 2", files: { "b.txt" => "b" })
        run_bin("git-backup-branch", chdir: repo)

        stdout, _, status = run_bin("git-backup-branch", "-l", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("commits")
      end
    end

    it "lists only branch names in quiet mode" do
      with_test_repo do |repo|
        run_bin("git-backup-branch", chdir: repo)

        stdout, _, status = run_bin("git-backup-branch", "-l", "-q", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).not_to include("commits")
        expect(stdout.strip).to match(/^main\.bak\.\d{4}-\d{2}-\d{2}$/)
      end
    end

    it "lists all backup branches with --all" do
      with_test_repo do |repo|
        # Create backups for different branches
        run_bin("git-backup-branch", chdir: repo)
        create_branch(repo, "feature")
        run_bin("git-backup-branch", chdir: repo)
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-backup-branch", "-l", "--all", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to match(/main\.bak/)
        expect(stdout).to match(/feature\.bak/)
      end
    end

    it "returns empty output when no backups exist" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-backup-branch", "-l", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end
  end
end
