# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-remote-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-remote-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-remote-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-remote-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-remote-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-remote-branch")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-remote-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end
  end

  describe "remote branch detection" do
    # Helper to create a repo with a remote
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
        run_command("git push -u origin HEAD 2>/dev/null", chdir: work_repo)

        yield work_repo, bare_repo
      end
    end

    it "returns the remote tracking branch" do
      with_remote_repo do |repo, _|
        stdout, _, status = run_bin("git-remote-branch", chdir: repo)

        expect(status).to eq(0)
        # Should return origin/main or origin/master
        expect(stdout.strip).to match(%r{^origin/(main|master)$})
      end
    end

    it "returns the correct remote for feature branches" do
      with_remote_repo do |repo, _|
        # Create and push a feature branch
        run_command("git checkout -b feature-test", chdir: repo)
        File.write(File.join(repo, "feature.txt"), "feature")
        run_command("git add feature.txt", chdir: repo)
        run_command("git commit -m 'Feature commit'", chdir: repo)
        run_command("git push -u origin feature-test 2>/dev/null", chdir: repo)

        stdout, _, status = run_bin("git-remote-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("origin/feature-test")
      end
    end

    it "returns empty when no remote tracking branch exists" do
      with_test_repo do |repo|
        # Local repo with no remote
        stdout, _, _status = run_bin("git-remote-branch", chdir: repo)

        # Should succeed but return empty (no remote branches)
        expect(stdout.strip).to be_empty
      end
    end
  end
end
