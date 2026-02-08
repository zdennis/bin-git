# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rubocop-branch" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rubocop-branch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-rubocop-branch version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-rubocop-branch", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rubocop-branch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-rubocop-branch")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-rubocop-branch", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains rubocop on branch changes" do
      stdout, _, _ = run_bin("git-rubocop-branch", "--help")

      expect(stdout).to include("rubocop")
      expect(stdout).to include("changed")
    end
  end

  # Note: Testing actual rubocop requires Ruby files and rubocop gem
end
