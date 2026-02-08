# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-repos-name" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-repos-name", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-repos-name version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-repos-name", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-repos-name", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-repos-name")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-repos-name", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end
  end

  describe "repository name extraction" do
    def with_github_remote(org, repo)
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        repo_path = File.join(tmpdir, "repo")
        FileUtils.mkdir_p(repo_path)

        run_command("git init", chdir: repo_path)
        run_command("git config user.email 'test@example.com'", chdir: repo_path)
        run_command("git config user.name 'Test User'", chdir: repo_path)
        run_command("git remote add origin git@github.com:#{org}/#{repo}.git", chdir: repo_path)

        File.write(File.join(repo_path, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: repo_path)
        run_command("git commit -m 'Initial commit'", chdir: repo_path)

        yield repo_path
      end
    end

    it "extracts org/repo from GitHub SSH URL" do
      with_github_remote("myorg", "myrepo") do |repo|
        stdout, _, status = run_bin("git-repos-name", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("myorg/myrepo")
      end
    end

    it "handles various organization names" do
      with_github_remote("rails", "rails") do |repo|
        stdout, _, status = run_bin("git-repos-name", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("rails/rails")
      end
    end

    it "handles repos with dashes" do
      with_github_remote("some-org", "my-cool-repo") do |repo|
        stdout, _, status = run_bin("git-repos-name", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("some-org/my-cool-repo")
      end
    end
  end

  describe "error handling" do
    it "fails when no remote is configured" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-repos-name", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end
end
