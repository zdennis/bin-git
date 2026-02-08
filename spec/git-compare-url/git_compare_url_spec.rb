# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-compare-url" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-compare-url", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-compare-url version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-compare-url", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-compare-url", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-compare-url")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-compare-url", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the compare URL functionality" do
      stdout, _, _ = run_bin("git-compare-url", "--help")

      expect(stdout).to include("compare")
      expect(stdout).to include("GitHub")
    end
  end

  describe "generating URLs" do
    def with_github_remote(remote_url)
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        repo_path = File.join(tmpdir, "repo")
        FileUtils.mkdir_p(repo_path)

        run_command("git init -b main", chdir: repo_path)
        run_command("git config user.email 'test@example.com'", chdir: repo_path)
        run_command("git config user.name 'Test User'", chdir: repo_path)
        run_command("git remote add origin #{remote_url}", chdir: repo_path)

        File.write(File.join(repo_path, "README.md"), "# Test\n")
        run_command("git add README.md", chdir: repo_path)
        run_command("git commit -m 'Initial commit'", chdir: repo_path)

        yield repo_path
      end
    end

    it "generates compare URL for current branch vs main" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        run_command("git checkout -b feature", chdir: repo)

        stdout, _, status = run_bin("git-compare-url", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("https://github.com/testorg/testrepo/compare/main...feature")
      end
    end

    it "generates compare URL with custom base" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        run_command("git checkout -b feature", chdir: repo)

        stdout, _, status = run_bin("git-compare-url", "develop", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("/compare/develop...feature")
      end
    end

    it "generates compare URL with two branches specified" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        stdout, _, status = run_bin("git-compare-url", "base-branch", "head-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("/compare/base-branch...head-branch")
      end
    end
  end
end
