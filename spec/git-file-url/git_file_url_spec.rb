# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-file-url" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-file-url", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-file-url version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-file-url", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-file-url", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-file-url")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-file-url", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "documents the -r option for ref" do
      stdout, _, _ = run_bin("git-file-url", "--help")

      expect(stdout).to include("-r")
      expect(stdout).to include("--ref")
    end

    it "documents the -l option for line" do
      stdout, _, _ = run_bin("git-file-url", "--help")

      expect(stdout).to include("-l")
      expect(stdout).to include("--line")
    end
  end

  describe "error handling" do
    it "fails when no file is provided" do
      stdout, _, status = run_bin("git-file-url")

      expect(status).not_to eq(0)
      expect(stdout).to include("Error")
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

    it "generates URL for a file" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        stdout, _, status = run_bin("git-file-url", "README.md", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("https://github.com/testorg/testrepo/blob/main/README.md")
      end
    end

    it "generates URL with specific ref" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        stdout, _, status = run_bin("git-file-url", "-r", "develop", "README.md", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("/blob/develop/README.md")
      end
    end

    it "generates URL with line number" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        stdout, _, status = run_bin("git-file-url", "-l", "42", "README.md", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("#L42")
      end
    end

    it "generates URL with line range" do
      with_github_remote("git@github.com:testorg/testrepo.git") do |repo|
        stdout, _, status = run_bin("git-file-url", "-l", "42:50", "README.md", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to include("#L42-L50")
      end
    end
  end
end
