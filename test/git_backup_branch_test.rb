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
    test_list_backups
    test_list_backups_empty
    test_help_flag
    test_missing_branch_error

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

      # Current behavior: git branch fails, script reports failure
      # This test documents current behavior
      refute status.success?, "should fail for nonexistent branch"
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
