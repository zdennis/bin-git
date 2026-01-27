#!/usr/bin/env ruby

require 'fileutils'
require 'tmpdir'
require 'open3'

class TestGitBackupBranch
  SCRIPT_PATH = File.expand_path('../../bin/git-backup-branch', __FILE__)

  def initialize
    @tests_run = 0
    @tests_passed = 0
    @tests_failed = 0
    @failures = []
  end

  def run_all
    puts "Running git-backup-branch tests...\n\n"

    test_backup_current_branch
    test_backup_specific_branch
    test_backup_with_tag
    test_backup_handles_existing_backup
    test_backup_no_false_collision_with_similar_names
    test_list_backups
    test_list_backups_empty
    test_help_flag
    test_missing_branch_error
    test_missing_remote_branch_error
    test_restore_single_backup
    test_restore_no_backups_error
    test_restore_with_force
    test_delete_backups
    test_delete_no_backups
    test_delete_with_force
    test_diff_shows_commits
    test_diff_no_backups_error
    test_diff_identical_branches
    test_list_all_backups
    test_quiet_mode_backup
    test_quiet_mode_suppresses_messages
    test_list_shows_commit_count

    print_summary
    exit(@tests_failed > 0 ? 1 : 0)
  end

  private

  def test_backup_current_branch
    with_test_repo do |dir|
      output, status = run_backup_branch

      assert status.success?, "backup should succeed"
      assert output.include?("Successfully backed up"), "should show success message"

      branches = git("branch").lines.map(&:strip)
      backup = branches.find { |b| b.include?(".bak.") }
      assert backup, "backup branch should exist"
      assert backup.include?("master.bak."), "backup should be named after master"
    end
  end

  def test_backup_specific_branch
    with_test_repo do |dir|
      git("checkout -b feature-branch")
      git("checkout master")

      output, status = run_backup_branch("feature-branch")

      assert status.success?, "backup should succeed"

      branches = git("branch").lines.map(&:strip)
      backup = branches.find { |b| b.include?("feature-branch.bak.") }
      assert backup, "backup of feature-branch should exist"
    end
  end

  def test_backup_with_tag
    with_test_repo do |dir|
      output, status = run_backup_branch("-t", "before-refactor")

      assert status.success?, "backup with tag should succeed"

      branches = git("branch").lines.map(&:strip)
      backup = branches.find { |b| b.include?(".before-refactor") }
      assert backup, "backup should include tag in name"
    end
  end

  def test_backup_handles_existing_backup
    with_test_repo do |dir|
      # Create first backup
      run_backup_branch
      # Create second backup
      output, status = run_backup_branch

      assert status.success?, "second backup should succeed"
      assert output.include?("exists"), "should mention existing backup"

      branches = git("branch").lines.map(&:strip)
      backups = branches.select { |b| b.include?("master.bak") }
      assert backups.length >= 2, "should have multiple backups"

      # Verify naming format is correct (no duplicate .bak)
      first_backup = backups.find { |b| b.match?(/^master\.bak\.\d{4}-\d{2}-\d{2}$/) }
      second_backup = backups.find { |b| b.match?(/^master\.bak2\.\d{4}-\d{2}-\d{2}$/) }
      assert first_backup, "first backup should be named master.bak.YYYY-MM-DD"
      assert second_backup, "second backup should be named master.bak2.YYYY-MM-DD (not master.bak.bak2)"
    end
  end

  def test_backup_no_false_collision_with_similar_names
    with_test_repo do |dir|
      # Create a branch with a similar name that could be matched by substring
      git("checkout -b my-feature")
      git("checkout master")

      # Backup my-feature
      run_backup_branch("my-feature")

      # Now create 'feature' branch and back it up
      git("checkout -b feature")
      git("checkout master")
      output, status = run_backup_branch("feature")

      # Should succeed without false collision detection
      assert status.success?, "backup should succeed without false collision"
      refute output.include?("exists"), "should not detect false collision from similar branch name"

      branches = git("branch").lines.map(&:strip)
      feature_backup = branches.find { |b| b.match?(/^feature\.bak\.\d{4}-\d{2}-\d{2}$/) }
      assert feature_backup, "feature backup should exist with correct name"
    end
  end

  def test_list_backups
    with_test_repo do |dir|
      run_backup_branch
      run_backup_branch("-t", "tagged")

      output, status = run_backup_branch("-l")

      assert status.success?, "list should succeed"
      assert output.lines.length >= 2, "should list multiple backups"
    end
  end

  def test_list_backups_empty
    with_test_repo do |dir|
      output, status = run_backup_branch("-l")

      assert status.success?, "list should succeed even with no backups"
      assert output.strip.empty?, "output should be empty when no backups"
    end
  end

  def test_help_flag
    with_test_repo do |dir|
      output, status = run_backup_branch("-h")

      assert status.success?, "help should succeed"
      assert output.include?("Usage:"), "should show usage"
      assert output.include?("--list"), "should document --list"
      assert output.include?("--tag"), "should document --tag"
    end
  end

  def test_missing_branch_error
    with_test_repo do |dir|
      output, status = run_backup_branch("nonexistent-branch")

      refute status.success?, "should fail for nonexistent branch"
      assert output.include?("does not exist"), "should show clear error message"
      assert output.include?("git branch -a"), "should suggest how to list branches"
    end
  end

  def test_missing_remote_branch_error
    with_test_repo do |dir|
      output, status = run_backup_branch("-r", "nonexistent-branch")

      refute status.success?, "should fail for nonexistent remote branch"
      assert output.include?("does not exist"), "should show clear error message"
      assert output.include?("git fetch"), "should suggest fetching"
    end
  end

  def test_restore_single_backup
    with_test_repo do |dir|
      # Create a backup
      run_backup_branch

      # Make a new commit
      File.write("new_file.txt", "new content")
      git("add new_file.txt")
      git("commit -m 'New commit after backup'")

      # Verify new file exists
      assert File.exist?("new_file.txt"), "new file should exist before restore"

      # Restore from backup (non-interactive since only one backup)
      output, status = run_backup_branch("--restore")

      assert status.success?, "restore should succeed"
      assert output.include?("Successfully restored"), "should show success message"

      # Verify we're back to the backup state
      refute File.exist?("new_file.txt"), "new file should not exist after restore"
    end
  end

  def test_restore_no_backups_error
    with_test_repo do |dir|
      output, status = run_backup_branch("--restore")

      refute status.success?, "restore should fail when no backups exist"
      assert output.include?("No backups found"), "should show error about no backups"
    end
  end

  def test_restore_with_force
    with_test_repo do |dir|
      # Create a backup
      run_backup_branch

      # Make uncommitted changes
      File.write("file1.txt", "modified content")

      # Try restore without force (should fail)
      output, status = run_backup_branch("--restore")
      refute status.success?, "restore without force should fail with uncommitted changes"
      assert output.include?("uncommitted changes"), "should mention uncommitted changes"

      # Restore with force
      output, status = run_backup_branch("--restore", "--force")
      assert status.success?, "restore with force should succeed"
      assert output.include?("Successfully restored"), "should show success message"

      # Verify changes were discarded
      content = File.read("file1.txt")
      assert content == "content 1", "file should be restored to original content"
    end
  end

  def test_delete_backups
    with_test_repo do |dir|
      # Create multiple backups
      run_backup_branch("-t", "first")
      run_backup_branch("-t", "second")

      # Verify backups exist
      output, _ = run_backup_branch("-l")
      assert output.lines.length >= 2, "should have multiple backups"

      # Delete with force (skip confirmation)
      output, status = run_backup_branch("--delete", "--force")

      assert status.success?, "delete should succeed"
      assert output.include?("Deleted"), "should show deleted message"

      # Verify backups are gone
      output, _ = run_backup_branch("-l")
      assert output.strip.empty?, "backups should be deleted"
    end
  end

  def test_delete_no_backups
    with_test_repo do |dir|
      output, status = run_backup_branch("--delete")

      assert status.success?, "delete with no backups should succeed"
      assert output.include?("No backups found"), "should mention no backups"
    end
  end

  def test_delete_with_force
    with_test_repo do |dir|
      run_backup_branch

      # Delete with force should not prompt
      output, status = run_backup_branch("--delete", "--force")

      assert status.success?, "delete with force should succeed"
      assert output.include?("Deleted"), "should show deleted message"
    end
  end

  def test_diff_shows_commits
    with_test_repo do |dir|
      # Create a backup
      run_backup_branch

      # Make new commits
      File.write("new_file.txt", "new content")
      git("add new_file.txt")
      git("commit -m 'Add new file'")

      # Run diff
      output, status = run_backup_branch("--diff")

      assert status.success?, "diff should succeed"
      assert output.include?("Commits since"), "should show commits header"
      assert output.include?("Add new file"), "should show commit message"
      assert output.include?("Summary"), "should show summary header"
    end
  end

  def test_diff_no_backups_error
    with_test_repo do |dir|
      output, status = run_backup_branch("--diff")

      refute status.success?, "diff should fail when no backups exist"
      assert output.include?("No backups found"), "should show error about no backups"
    end
  end

  def test_diff_identical_branches
    with_test_repo do |dir|
      # Create a backup
      run_backup_branch

      # Run diff without making changes
      output, status = run_backup_branch("--diff")

      assert status.success?, "diff should succeed"
      assert output.include?("No commits since backup"), "should indicate branches are identical"
    end
  end

  def test_list_all_backups
    with_test_repo do |dir|
      # Create backups for master
      run_backup_branch

      # Create another branch and back it up
      git("checkout -b feature-branch")
      File.write("feature.txt", "feature content")
      git("add feature.txt")
      git("commit -m 'Feature commit'")
      run_backup_branch
      git("checkout master")

      # List all should show both
      output, status = run_backup_branch("-l", "--all")

      assert status.success?, "list all should succeed"
      assert output.include?("master.bak"), "should include master backup"
      assert output.include?("feature-branch.bak"), "should include feature-branch backup"
    end
  end

  def test_quiet_mode_backup
    with_test_repo do |dir|
      output, status = run_backup_branch("--quiet")

      assert status.success?, "quiet backup should succeed"
      # In quiet mode, should only output the backup branch name
      assert output.strip.match?(/^master\.bak\.\d{4}-\d{2}-\d{2}$/), "should output only backup branch name"
      refute output.include?("Successfully"), "should not include verbose messages"
      refute output.include?("git branch"), "should not show the command"
    end
  end

  def test_quiet_mode_suppresses_messages
    with_test_repo do |dir|
      # Create first backup
      run_backup_branch("--quiet")
      # Create second backup - should not show "exists" message in quiet mode
      output, status = run_backup_branch("--quiet")

      assert status.success?, "second quiet backup should succeed"
      refute output.include?("exists"), "should not show exists message in quiet mode"
    end
  end

  def test_list_shows_commit_count
    with_test_repo do |dir|
      run_backup_branch

      output, status = run_backup_branch("-l")

      assert status.success?, "list should succeed"
      assert output.include?("commits"), "should show commit count"
      # Test repo has 3 commits (initial + file1 + file2)
      assert output.include?("3 commits"), "should show correct commit count"
    end
  end

  # Test helpers

  def with_test_repo
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        git("init")
        git("config user.email 'test@test.com'")
        git("config user.name 'Test User'")

        # Create initial commit
        File.write("README.md", "# Test Repo")
        git("add README.md")
        git("commit -m 'Initial commit'")

        # Add a few more commits
        File.write("file1.txt", "content 1")
        git("add file1.txt")
        git("commit -m 'Add file1'")

        File.write("file2.txt", "content 2")
        git("add file2.txt")
        git("commit -m 'Add file2'")

        yield dir
      end
    end
  end

  def git(command)
    `git #{command} 2>&1`.tap do |output|
      unless $?.success?
        # Don't fail on expected failures in tests
      end
    end
  end

  def run_backup_branch(*args)
    cmd = [SCRIPT_PATH] + args
    stdout, stderr, status = Open3.capture3(*cmd)
    [stdout + stderr, status]
  end

  def assert(condition, message = "Assertion failed")
    @tests_run += 1
    if condition
      @tests_passed += 1
      print "."
    else
      @tests_failed += 1
      @failures << "#{caller_test_name}: #{message}"
      print "F"
    end
  end

  def refute(condition, message = "Refutation failed")
    assert(!condition, message)
  end

  def caller_test_name
    caller.find { |line| line.include?("test_") }&.match(/`([^']+)'/)[1] || "unknown"
  end

  def print_summary
    puts "\n\n"
    puts "=" * 50
    puts "#{@tests_run} assertions, #{@tests_passed} passed, #{@tests_failed} failed"

    if @failures.any?
      puts "\nFailures:"
      @failures.each { |f| puts "  - #{f}" }
    end

    puts "=" * 50
  end
end

TestGitBackupBranch.new.run_all
