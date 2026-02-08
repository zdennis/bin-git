# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-rbranch" do
  # git-rbranch is an alias for git-remote-branch

  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-rbranch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-remote-branch version \d+\.\d+\.\d+/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-rbranch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("Usage:")
    end
  end
end
