# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-1m" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-1m", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-1m version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-1m", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-1m", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-1m")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-1m", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "mentions it is an alias for git 1" do
      stdout, _, _ = run_bin("git-1m", "--help")

      expect(stdout).to include("alias")
    end
  end

  describe "showing commits" do
    it "shows commits on the current branch vs main" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature via 1m", files: { "f.txt" => "content" })

        stdout, _, status = run_bin("git-1m", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Feature via 1m")
      end
    end

    it "passes options through to git 1" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Pass through test", files: { "p.txt" => "pass" })

        stdout, _, status = run_bin("git-1m", "--author", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Test User")
      end
    end
  end
end
