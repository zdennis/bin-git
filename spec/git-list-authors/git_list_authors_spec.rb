# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-list-authors" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-list-authors", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-list-authors version \d+\.\d+\.\d+/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-list-authors", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-list-authors")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-list-authors", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the author listing functionality" do
      stdout, _, _ = run_bin("git-list-authors", "--help")

      expect(stdout).to include("author")
    end

    it "documents the -v verbose option" do
      stdout, _, _ = run_bin("git-list-authors", "--help")

      expect(stdout).to include("-v")
      expect(stdout).to include("verbose")
    end
  end

  describe "listing authors" do
    it "lists authors for a file" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add file", files: { "code.rb" => "code" })

        stdout, _, status = run_bin("git-list-authors", "code.rb", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Test User")
      end
    end

    it "shows unique authors only" do
      with_test_repo do |repo|
        create_commit(repo, message: "Commit 1", files: { "file.rb" => "v1" })
        create_commit(repo, message: "Commit 2", files: { "file.rb" => "v2" })
        create_commit(repo, message: "Commit 3", files: { "file.rb" => "v3" })

        stdout, _, status = run_bin("git-list-authors", "file.rb", chdir: repo)

        expect(status).to eq(0)
        # Should only show Test User once
        expect(stdout.scan("Test User").length).to eq(1)
      end
    end

    it "runs with verbose flag" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add file", files: { "code.rb" => "code" })

        stdout, _, status = run_bin("git-list-authors", "-v", "code.rb", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Running command:")
      end
    end
  end
end
