# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-review" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-review", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-review version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-review", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-review", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-review")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-review", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the review purpose" do
      stdout, _, _ = run_bin("git-review", "--help")

      expect(stdout).to include("remote")
      expect(stdout).to include("local")
    end
  end

  describe "reviewing commits" do
    def with_remote_repo_and_extra_commits
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        bare_repo = File.join(tmpdir, "remote.git")
        work_repo = File.join(tmpdir, "work")
        other_repo = File.join(tmpdir, "other")

        # Create bare remote
        FileUtils.mkdir_p(bare_repo)
        run_command("git init --bare -b main", chdir: bare_repo)

        # Create working repo
        FileUtils.mkdir_p(work_repo)
        run_command("git init -b main", chdir: work_repo)
        run_command("git config user.email 'test@example.com'", chdir: work_repo)
        run_command("git config user.name 'Test User'", chdir: work_repo)
        run_command("git remote add origin #{bare_repo}", chdir: work_repo)

        File.write(File.join(work_repo, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: work_repo)
        run_command("git commit -m 'Initial commit'", chdir: work_repo)
        run_command("git push -u origin HEAD 2>/dev/null", chdir: work_repo)

        # Clone to another repo and make commits
        run_command("git clone #{bare_repo} #{other_repo}", chdir: tmpdir)
        run_command("git config user.email 'other@example.com'", chdir: other_repo)
        run_command("git config user.name 'Other User'", chdir: other_repo)
        File.write(File.join(other_repo, "other.txt"), "other content")
        run_command("git add other.txt", chdir: other_repo)
        run_command("git commit -m 'Commit from other user'", chdir: other_repo)
        run_command("git push 2>/dev/null", chdir: other_repo)

        # Fetch in work repo to see remote changes
        run_command("git fetch", chdir: work_repo)

        yield work_repo
      end
    end

    it "shows commits on remote not on local" do
      with_remote_repo_and_extra_commits do |repo|
        stdout, _, status = run_bin("git-review", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Commit from other user")
      end
    end

    it "shows empty output when local is up to date" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        bare_repo = File.join(tmpdir, "remote.git")
        work_repo = File.join(tmpdir, "work")

        FileUtils.mkdir_p(bare_repo)
        run_command("git init --bare -b main", chdir: bare_repo)

        FileUtils.mkdir_p(work_repo)
        run_command("git init -b main", chdir: work_repo)
        run_command("git config user.email 'test@example.com'", chdir: work_repo)
        run_command("git config user.name 'Test User'", chdir: work_repo)
        run_command("git remote add origin #{bare_repo}", chdir: work_repo)

        File.write(File.join(work_repo, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: work_repo)
        run_command("git commit -m 'Initial commit'", chdir: work_repo)
        run_command("git push -u origin HEAD 2>/dev/null", chdir: work_repo)

        stdout, _, status = run_bin("git-review", chdir: work_repo)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end
  end

  describe "error handling" do
    it "fails when no remote branch exists" do
      with_test_repo do |repo|
        _stdout, stderr, status = run_bin("git-review", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end
end
