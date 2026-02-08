# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-whatadded" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-whatadded", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-whatadded version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-whatadded", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-whatadded", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-whatadded")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-whatadded", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains finding the commit that added a file" do
      stdout, _, _ = run_bin("git-whatadded", "--help")

      expect(stdout).to include("commit")
      expect(stdout).to include("added")
    end
  end

  describe "error handling" do
    it "fails when no file is provided" do
      stdout, stderr, status = run_bin("git-whatadded")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("file")
    end
  end

  describe "finding commits" do
    it "finds the commit that added a file" do
      with_test_repo do |repo|
        create_commit(repo, message: "Add feature file", files: { "feature.rb" => "code" })

        stdout, _, status = run_bin("git-whatadded", "feature.rb", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Add feature file")
      end
    end
  end
end
