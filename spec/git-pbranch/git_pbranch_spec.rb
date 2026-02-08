# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-pbranch" do
  # git-pbranch is an alias for git-previous-branch

  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-pbranch", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-previous-branch version \d+\.\d+\.\d+/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-pbranch", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("Usage:")
    end
  end
end
