# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-backup-branch" do
  describe "creating backups" do
    it "creates a backup of the current branch" do
      with_test_repo do |repo|
        create_commit(repo, message: "Test commit", files: { "file.txt" => "content" })

        stdout, stderr, status = run_bin("git-backup-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Successfully backed up")

        # Verify backup branch was created
        branches, _, _ = run_command("git branch", chdir: repo)
        expect(branches).to match(/main\.bak\.\d{4}-\d{2}-\d{2}/)
      end
    end

    it "creates a backup of a specified branch" do
      with_test_repo do |repo|
        create_branch(repo, "feature-branch")
        create_commit(repo, message: "Feature work", files: { "feature.txt" => "data" })
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-backup-branch", "feature-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Successfully backed up")

        branches, _, _ = run_command("git branch", chdir: repo)
        expect(branches).to match(/feature-branch\.bak\.\d{4}-\d{2}-\d{2}/)
      end
    end

    it "adds a tag to the backup name with -t option" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-backup-branch", "-t", "before-rebase", chdir: repo)

        expect(status).to eq(0)

        branches, _, _ = run_command("git branch", chdir: repo)
        expect(branches).to include(".before-rebase")
      end
    end

    it "normalizes tag names (lowercase, dashes for spaces)" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-backup-branch", "-t", "Before Main Rebase", chdir: repo)

        expect(status).to eq(0)

        branches, _, _ = run_command("git branch", chdir: repo)
        expect(branches).to include(".before-main-rebase")
      end
    end

    it "creates numbered backups when backup already exists for today" do
      with_test_repo do |repo|
        # Create first backup
        run_bin("git-backup-branch", chdir: repo)
        # Create second backup
        stdout, _, status = run_bin("git-backup-branch", chdir: repo)

        expect(status).to eq(0)

        branches, _, _ = run_command("git branch", chdir: repo)
        # Should have both main.bak.DATE and main.bak2.DATE
        expect(branches).to match(/main\.bak\.\d{4}/)
        expect(branches).to match(/main\.bak2\.\d{4}/)
      end
    end

    it "outputs only branch name in quiet mode" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-backup-branch", "-q", chdir: repo)

        expect(status).to eq(0)
        # Quiet mode should output just the branch name
        expect(stdout.strip).to match(/^main\.bak\.\d{4}-\d{2}-\d{2}$/)
      end
    end

    it "fails when branch does not exist" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-backup-branch", "nonexistent-branch", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("does not exist")
      end
    end
  end
end
