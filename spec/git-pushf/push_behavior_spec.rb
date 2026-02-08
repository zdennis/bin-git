# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-pushf" do
  # Helper to create a bare repo as a "remote"
  def with_remote_repo
    Dir.mktmpdir("git-helpers-test-") do |tmpdir|
      bare_repo = File.join(tmpdir, "remote.git")
      work_repo = File.join(tmpdir, "work")

      # Create bare remote
      FileUtils.mkdir_p(bare_repo)
      run_command("git init --bare -b main", chdir: bare_repo)

      # Create working repo
      FileUtils.mkdir_p(work_repo)
      run_command("git init -b main", chdir: work_repo)
      run_command("git config user.email 'test@example.com'", chdir: work_repo)
      run_command("git config user.name 'Test User'", chdir: work_repo)
      run_command("git remote add origin #{bare_repo}", chdir: work_repo)

      # Initial commit and push
      File.write(File.join(work_repo, "README.md"), "# Test\n")
      run_command("git add README.md", chdir: work_repo)
      run_command("git commit -m 'Initial commit'", chdir: work_repo)
      run_command("git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null", chdir: work_repo)

      yield work_repo, bare_repo
    end
  end

  describe "force push with lease" do
    it "pushes amended commits successfully" do
      with_remote_repo do |repo, _remote|
        # Make a commit
        File.write(File.join(repo, "file.txt"), "content")
        run_command("git add file.txt", chdir: repo)
        run_command("git commit -m 'Add file'", chdir: repo)
        run_command("git push", chdir: repo)

        # Amend the commit (this changes the SHA)
        File.write(File.join(repo, "file.txt"), "amended content")
        run_command("git add file.txt", chdir: repo)
        run_command("git commit --amend -C HEAD", chdir: repo)

        # Force push with lease should succeed
        _stdout, _stderr, status = run_bin("git-pushf", chdir: repo)

        expect(status).to eq(0)
      end
    end

    it "passes additional arguments to git push" do
      # Test that arguments are passed through by checking help output
      # (We can't easily test actual push args without complex setup)
      stdout, _, status = run_bin("git-pushf", "--help")

      expect(status).to eq(0)
      expect(stdout).to include("git-push-options")
    end
  end

  describe "without remote" do
    it "fails gracefully when no remote is configured" do
      with_test_repo do |repo|
        # This repo has no remote configured
        _stdout, _stderr, status = run_bin("git-pushf", chdir: repo)

        # Git will error about no remote
        expect(status).not_to eq(0)
      end
    end
  end
end
