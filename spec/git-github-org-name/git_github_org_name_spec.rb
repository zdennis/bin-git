# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-github-org-name" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-github-org-name", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-github-org-name version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-github-org-name", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-github-org-name", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-github-org-name")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-github-org-name", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the organization name functionality" do
      stdout, _, _ = run_bin("git-github-org-name", "--help")

      expect(stdout).to include("organization")
    end
  end

  describe "extracting org name" do
    def with_github_remote(remote_url)
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        repo_path = File.join(tmpdir, "repo")
        FileUtils.mkdir_p(repo_path)

        run_command("git init", chdir: repo_path)
        run_command("git config user.email 'test@example.com'", chdir: repo_path)
        run_command("git config user.name 'Test User'", chdir: repo_path)
        run_command("git remote add origin #{remote_url}", chdir: repo_path)

        File.write(File.join(repo_path, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: repo_path)
        run_command("git commit -m 'Initial commit'", chdir: repo_path)

        yield repo_path
      end
    end

    it "extracts organization from SSH URL" do
      with_github_remote("git@github.com:myorg/myrepo.git") do |repo|
        stdout, _, status = run_bin("git-github-org-name", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("myorg")
      end
    end

    it "extracts organization from HTTPS URL" do
      with_github_remote("https://github.com/rails/rails.git") do |repo|
        stdout, _, status = run_bin("git-github-org-name", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("rails")
      end
    end
  end

  describe "error handling" do
    it "fails when no origin remote exists" do
      with_test_repo do |repo|
        _, stderr, status = run_bin("git-github-org-name", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end
end
