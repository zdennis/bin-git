# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-backup-branch" do
  describe "restoring backups" do
    it "restores the current branch from the most recent backup" do
      with_test_repo do |repo|
        # Create initial state and backup
        create_commit(repo, message: "Original", files: { "file.txt" => "original" })
        original_sha = head_sha(repo)
        run_bin("git-backup-branch", "-q", chdir: repo)

        # Make changes after backup
        create_commit(repo, message: "New work", files: { "file.txt" => "changed" })
        expect(head_sha(repo)).not_to eq(original_sha)

        # Restore from backup
        stdout, _, status = run_bin("git-backup-branch", "--restore", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Successfully restored")
        expect(head_sha(repo)).to eq(original_sha)
      end
    end

    it "restores a specified branch from backup" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature work", files: { "f.txt" => "v1" })
        feature_sha = head_sha(repo)
        run_bin("git-backup-branch", "-q", chdir: repo)
        create_commit(repo, message: "More work", files: { "f.txt" => "v2" })

        checkout_branch(repo, "main")

        # Restore requires interactive selection when multiple backups don't exist
        # Use --force to skip the interactive prompt
        stdout, stderr, status = run_bin("git-backup-branch", "--restore", "--force", "feature", chdir: repo)

        expect(status).to eq(0), "stdout: #{stdout}, stderr: #{stderr}"

        # Check feature branch was restored
        checkout_branch(repo, "feature")
        expect(head_sha(repo)).to eq(feature_sha)
      end
    end

    it "fails when branch has uncommitted changes" do
      with_test_repo do |repo|
        run_bin("git-backup-branch", chdir: repo)

        # Create uncommitted changes
        File.write(File.join(repo, "dirty.txt"), "uncommitted")
        run_command("git add dirty.txt", chdir: repo)

        stdout, stderr, status = run_bin("git-backup-branch", "--restore", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("uncommitted changes")
      end
    end

    it "force restores with --force flag" do
      with_test_repo do |repo|
        run_bin("git-backup-branch", "-q", chdir: repo)
        original_sha = head_sha(repo)

        # Make changes
        create_commit(repo, message: "New", files: { "new.txt" => "new" })
        File.write(File.join(repo, "dirty.txt"), "uncommitted")
        run_command("git add dirty.txt", chdir: repo)

        stdout, _, status = run_bin("git-backup-branch", "--restore", "--force", chdir: repo)

        expect(status).to eq(0)
        expect(head_sha(repo)).to eq(original_sha)
      end
    end

    it "fails when no backups exist" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-backup-branch", "--restore", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("No backups found")
      end
    end
  end
end
