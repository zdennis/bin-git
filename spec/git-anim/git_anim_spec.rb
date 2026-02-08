# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-anim" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-anim", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-anim version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-anim", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-anim", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-anim")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-anim", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the acceptance branch workflow" do
      stdout, _, _ = run_bin("git-anim", "--help")

      expect(stdout).to include("acceptance")
      expect(stdout).to include("main")
    end
  end

  describe "listing branches" do
    it "shows header when run with acceptance branch" do
      with_test_repo do |repo|
        # Create acceptance branch with a commit
        run_command("git checkout -b acceptance", chdir: repo)
        create_commit(repo, message: "Acceptance commit", files: { "a.txt" => "a" })
        checkout_branch(repo, "main")

        stdout, _, _ = run_bin("git-anim", chdir: repo)

        # Returns grep's exit code (1 if no merge commits found)
        expect(stdout).to include("Branches merged into acceptance")
      end
    end

    it "shows merged branches in acceptance not in main" do
      with_test_repo do |repo|
        # Create a feature branch and merge it into acceptance
        create_branch(repo, "feature-x")
        create_commit(repo, message: "Feature X", files: { "x.txt" => "x" })
        checkout_branch(repo, "main")
        run_command("git checkout -b acceptance", chdir: repo)
        run_command("git merge feature-x --no-ff -m 'Merge branch feature-x'", chdir: repo)
        checkout_branch(repo, "main")

        stdout, _, status = run_bin("git-anim", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("feature-x")
      end
    end
  end
end
