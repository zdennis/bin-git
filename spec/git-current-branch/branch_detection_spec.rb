# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-current-branch" do
  describe "branch detection" do
    it "returns the current branch name on main" do
      with_test_repo do |repo|
        # Default branch is typically 'main' or 'master'
        stdout, stderr, status = run_bin("git-current-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stderr).to be_empty
        expect(stdout).to match(/^(main|master)$/)
      end
    end

    it "returns the branch name without trailing newline" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-current-branch", chdir: repo)

        expect(status).to eq(0)
        # Should not end with newline - useful for command substitution
        expect(stdout).not_to end_with("\n")
      end
    end

    it "returns the correct name after switching branches" do
      with_test_repo do |repo|
        create_branch(repo, "feature-branch")

        stdout, stderr, status = run_bin("git-current-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stderr).to be_empty
        expect(stdout).to eq("feature-branch")
      end
    end

    it "handles branch names with slashes" do
      with_test_repo do |repo|
        create_branch(repo, "feature/my-feature")

        stdout, _, status = run_bin("git-current-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to eq("feature/my-feature")
      end
    end

    it "handles branch names with dashes and underscores" do
      with_test_repo do |repo|
        create_branch(repo, "my_feature-branch_v2")

        stdout, _, status = run_bin("git-current-branch", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to eq("my_feature-branch_v2")
      end
    end
  end

  describe "error handling" do
    it "reports error when not in a git repository" do
      Dir.mktmpdir("not-a-repo-") do |tmpdir|
        _stdout, stderr, status = run_bin("git-current-branch", chdir: tmpdir)

        expect(status).not_to eq(0)
        expect(stderr).to include("Error")
      end
    end
  end
end
