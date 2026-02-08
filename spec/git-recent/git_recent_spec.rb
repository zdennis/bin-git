# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-recent" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-recent", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-recent version \d+\.\d+\.\d+/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-recent", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-recent")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-recent", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the default count" do
      stdout, _, _ = run_bin("git-recent", "--help")

      expect(stdout).to include("10")
    end
  end

  describe "listing recent branches" do
    it "lists branches sorted by recent activity" do
      with_test_repo do |repo|
        # Create branches with explicit commit dates to guarantee order
        # Use dates in the future to ensure they're more recent than the initial commit
        create_branch(repo, "feature-a")
        run_command(
          "GIT_COMMITTER_DATE='2099-01-01 12:00:00' git commit --allow-empty -m 'Commit on feature-a'",
          chdir: repo
        )
        checkout_branch(repo, "main")
        create_branch(repo, "feature-b")
        run_command(
          "GIT_COMMITTER_DATE='2099-01-02 12:00:00' git commit --allow-empty -m 'Commit on feature-b'",
          chdir: repo
        )

        stdout, _, status = run_bin("git-recent", chdir: repo)

        expect(status).to eq(0)
        lines = stdout.lines.map(&:strip)
        # feature-b should be first (most recent commit)
        expect(lines.first).to eq("feature-b")
      end
    end

    it "limits output to specified count" do
      with_test_repo do |repo|
        # Create several branches
        %w[a b c d e].each do |name|
          checkout_branch(repo, "main")
          create_branch(repo, "branch-#{name}")
        end

        stdout, _, status = run_bin("git-recent", "3", chdir: repo)

        expect(status).to eq(0)
        lines = stdout.lines.map(&:strip).reject(&:empty?)
        expect(lines.length).to eq(3)
      end
    end

    it "defaults to 10 branches" do
      with_test_repo do |repo|
        # Create more than 10 branches
        15.times do |i|
          checkout_branch(repo, "main")
          create_branch(repo, "branch-#{i}")
        end

        stdout, _, status = run_bin("git-recent", chdir: repo)

        expect(status).to eq(0)
        lines = stdout.lines.map(&:strip).reject(&:empty?)
        expect(lines.length).to eq(10)
      end
    end
  end

  describe "verbose mode" do
    it "shows the command being run with -v" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-recent", "-v", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Running command:")
      end
    end
  end
end
