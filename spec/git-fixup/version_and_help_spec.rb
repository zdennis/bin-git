# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-fixup" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-fixup", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-fixup version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-fixup", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-fixup", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-fixup")
      expect(stdout).to include("Usage:")
      expect(stdout).to include("Options:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-fixup", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains fixup and autosquash workflow" do
      stdout, _, _ = run_bin("git-fixup", "--help")

      expect(stdout).to include("fixup")
      expect(stdout).to include("autosquash")
    end

    it "includes usage examples" do
      stdout, _, _ = run_bin("git-fixup", "--help")

      expect(stdout).to include("Examples:")
    end
  end
end
