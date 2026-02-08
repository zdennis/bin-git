# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-m1" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-m1", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-m1 version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-m1", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-m1", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-m1")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-m1", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the main comparison functionality" do
      stdout, _, _ = run_bin("git-m1", "--help")

      expect(stdout).to include("main")
    end
  end

  describe "showing commits" do
    it "shows empty output when on main with no difference" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-m1", chdir: repo)

        expect(status).to eq(0)
        expect(stdout.strip).to be_empty
      end
    end

    it "shows commits on main not on feature branch" do
      with_test_repo do |repo|
        # Create a feature branch
        create_branch(repo, "feature")

        # Go back to main and add commits
        checkout_branch(repo, "main")
        create_commit(repo, message: "Main commit 1", files: { "m1.txt" => "1" })
        create_commit(repo, message: "Main commit 2", files: { "m2.txt" => "2" })

        # Go to feature branch
        checkout_branch(repo, "feature")

        stdout, _, status = run_bin("git-m1", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Main commit 1")
        expect(stdout).to include("Main commit 2")
      end
    end
  end
end
