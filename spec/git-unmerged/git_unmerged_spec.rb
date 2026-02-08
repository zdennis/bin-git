# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-unmerged" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-unmerged", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-unmerged version \d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-unmerged", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, _, status = run_bin("git-unmerged", "--help")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-unmerged", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the unmerged commits functionality" do
      stdout, _, _ = run_bin("git-unmerged", "--help")

      expect(stdout).to include("unmerged")
      expect(stdout).to include("branch")
    end

    it "documents the --remote option" do
      stdout, _, _ = run_bin("git-unmerged", "--help")

      expect(stdout).to include("--remote")
    end

    it "documents the --upstream option" do
      stdout, _, _ = run_bin("git-unmerged", "--help")

      expect(stdout).to include("--upstream")
    end
  end

  describe "listing unmerged commits" do
    it "reports when no branches are out of sync" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-unmerged", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("no local branches out of sync")
      end
    end

    it "detects branches with unmerged commits" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature commit", files: { "f.txt" => "f" })

        stdout, _, status = run_bin("git-unmerged", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("feature")
      end
    end
  end
end
