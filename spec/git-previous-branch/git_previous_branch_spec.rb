# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-previous-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-previous-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-previous-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-previous-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-previous-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-previous-branch")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-previous-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end
  end

  describe "previous branch detection" do
    it "returns the previous branch after checkout" do
      with_test_repo do |repo|
        # Start on main, create and switch to feature
        create_branch(repo, "feature-branch")
        # Switch back to main
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-previous-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("feature-branch")
      end
    end

    it "tracks multiple branch switches" do
      with_test_repo do |repo|
        create_branch(repo, "branch-a")
        checkout_branch(repo, "main")
        create_branch(repo, "branch-b")
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-previous-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("branch-b")
      end
    end

    it "handles branch names with slashes" do
      with_test_repo do |repo|
        create_branch(repo, "feature/my-feature")
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-previous-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to eq("feature/my-feature")
      end
    end
  end

  describe "error handling" do
    it "fails when no previous branch exists" do
      with_test_repo do |repo|
        # Fresh repo with no branch switches
        # The initial commit doesn't create a checkout entry
        stdout, stderr, status = run_bin("git-previous-branch", chdir: repo)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end
end
