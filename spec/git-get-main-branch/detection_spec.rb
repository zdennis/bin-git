# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-get-main-branch" do
  describe "branch detection" do
    # Helper to create repo with specific default branch name
    def with_repo_having_branch(branch_name)
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        repo_path = File.join(tmpdir, "repo")
        FileUtils.mkdir_p(repo_path)

        run_command("git init", chdir: repo_path)
        run_command("git config user.email 'test@example.com'", chdir: repo_path)
        run_command("git config user.name 'Test User'", chdir: repo_path)

        # Create initial commit on default branch
        File.write(File.join(repo_path, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: repo_path)
        run_command("git commit -m 'Initial commit'", chdir: repo_path)

        # Rename to desired branch name if not already
        current, _, _ = run_command("git rev-parse --abbrev-ref HEAD", chdir: repo_path)
        current = current.strip
        if current != branch_name
          run_command("git branch -m #{current} #{branch_name}", chdir: repo_path)
        end

        yield repo_path
      end
    end

    it "returns 'main' when main branch exists" do
      with_repo_having_branch("main") do |repo|
        stdout, stderr, status = run_bin("git-get-main-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stderr).to be_empty
        expect(stdout.strip).to eq("main")
      end
    end

    it "returns 'master' when only master exists" do
      with_repo_having_branch("master") do |repo|
        stdout, stderr, status = run_bin("git-get-main-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stderr).to be_empty
        expect(stdout.strip).to eq("master")
      end
    end

    it "prefers 'main' over 'master' when both exist" do
      with_repo_having_branch("main") do |repo|
        # Create master branch too
        run_command("git branch master", chdir: repo)

        stdout, _, status = run_bin("git-get-main-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("main")
      end
    end

    it "works regardless of current branch" do
      with_repo_having_branch("main") do |repo|
        # Create and switch to a feature branch
        run_command("git checkout -b feature-branch", chdir: repo)

        stdout, _, status = run_bin("git-get-main-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("main")
      end
    end
  end

  describe "error handling" do
    it "fails when neither main nor master exists" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        repo_path = File.join(tmpdir, "repo")
        FileUtils.mkdir_p(repo_path)

        run_command("git init", chdir: repo_path)
        run_command("git config user.email 'test@example.com'", chdir: repo_path)
        run_command("git config user.name 'Test User'", chdir: repo_path)

        # Create commit on a differently named branch
        File.write(File.join(repo_path, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: repo_path)
        run_command("git commit -m 'Initial commit'", chdir: repo_path)
        run_command("git branch -m develop", chdir: repo_path)

        stdout, stderr, status = run_bin("git-get-main-branch", chdir: repo_path)

        expect(status).to eq(1)
        expect(stderr).to include("Error")
        expect(stderr).to include("main")
        expect(stderr).to include("master")
      end
    end

    it "fails when not in a git repository" do
      Dir.mktmpdir("not-a-repo-") do |tmpdir|
        stdout, stderr, status = run_bin("git-get-main-branch", chdir: tmpdir)

        expect(status).not_to eq(0)
      end
    end
  end
end
