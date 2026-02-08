# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-cbranch" do
  # git-cbranch is an alias for git-current-branch

  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-cbranch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-current-branch version \d+\.\d+\.\d+/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-cbranch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("Usage:")
    end
  end

  describe "functionality" do
    it "outputs current branch name" do
      with_test_repo do |repo|
        stdout, _, status = run_bin("git-cbranch", chdir: repo)

        # Default branch in test repos is typically master or main
        expect(status).to eq(0)
        expect(stdout).not_to be_empty
      end
    end
  end
end
