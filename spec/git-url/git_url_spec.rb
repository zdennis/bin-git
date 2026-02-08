# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-url" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-url", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-url version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-url", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-url", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-url")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-url", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "documents supported URL formats" do
      stdout, _, _ = run_bin("git-url", "--help")

      expect(stdout).to include("git://")
      expect(stdout).to include("git@")
    end
  end

  describe "URL conversion" do
    def with_remote(remote_url)
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

    it "converts SSH URL to HTTPS" do
      with_remote("git@github.com:rails/rails.git") do |repo|
        stdout, _, status = run_bin("git-url", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("https://github.com/rails/rails")
      end
    end

    it "converts SSH URL without .git suffix" do
      with_remote("git@github.com:myorg/myrepo") do |repo|
        stdout, _, status = run_bin("git-url", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("https://github.com/myorg/myrepo")
      end
    end

    it "passes through HTTPS URLs" do
      with_remote("https://github.com/rails/rails.git") do |repo|
        stdout, _, status = run_bin("git-url", chdir: repo)

        expect(status).to eq(0)
        # Script returns URL - format may vary
        expect(stdout.strip).to include("github.com")
        expect(stdout.strip).to include("rails/rails")
      end
    end
  end

  describe "error handling" do
    it "fails when no origin remote exists" do
      with_test_repo do |repo|
        stdout, stderr, status = run_bin("git-url", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end
end
