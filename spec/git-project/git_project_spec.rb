# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-project" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-project", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-project version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-project", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-project", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-project")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-project", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains project initialization" do
      stdout, _, _ = run_bin("git-project", "--help")

      expect(stdout).to include("git")
      expect(stdout).to include("README")
    end
  end

  describe "error handling" do
    it "fails when no project name is provided" do
      _stdout, stderr, status = run_bin("git-project")

      expect(status).not_to eq(0)
      expect(stderr).to include("Error")
      expect(stderr).to include("project")
    end
  end

  describe "creating projects" do
    it "creates a new project directory with git repo" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        project_name = "test-project-#{Time.now.to_i}"

        stdout, _, status = run_bin("git-project", project_name, chdir: tmpdir)

        expect(status).to eq(0)
        expect(stdout).to include(project_name)

        project_dir = File.join(tmpdir, project_name)
        expect(Dir.exist?(project_dir)).to be true
        expect(Dir.exist?(File.join(project_dir, ".git"))).to be true
        expect(File.exist?(File.join(project_dir, "README"))).to be true
      end
    end

    it "fails if directory already exists" do
      Dir.mktmpdir("git-helpers-test-") do |tmpdir|
        project_name = "existing-project"
        FileUtils.mkdir_p(File.join(tmpdir, project_name))

        _, stderr, status = run_bin("git-project", project_name, chdir: tmpdir)

        expect(status).not_to eq(0)
        expect(stderr).to include("already exists")
      end
    end
  end
end
