# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-changed-specs" do
  describe "--version" do
    it "displays version information" do
      stdout, stderr, status = run_bin("git-changed-specs", "--version")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to match(/git-changed-specs version \d+\.\d+\.\d+/)
    end

    it "accepts -v as shorthand" do
      stdout, _, status = run_bin("git-changed-specs", "-v")

      expect(status).to eq(0)
      expect(stdout).to match(/version/)
    end
  end

  describe "--help" do
    it "displays help information" do
      stdout, stderr, status = run_bin("git-changed-specs", "--help")

      expect(status).to eq(0)
      expect(stderr).to be_empty
      expect(stdout).to include("git-changed-specs")
      expect(stdout).to include("Usage:")
    end

    it "accepts -h as shorthand" do
      stdout, _, status = run_bin("git-changed-specs", "-h")

      expect(status).to eq(0)
      expect(stdout).to include("Usage:")
    end

    it "explains the spec file filtering" do
      stdout, _, _ = run_bin("git-changed-specs", "--help")

      expect(stdout).to include("spec")
      expect(stdout).to include("_spec.rb")
    end
  end

  describe "listing changed specs" do
    it "lists only spec files that changed" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Add files", files: {
          "app/model.rb" => "code",
          "spec/model_spec.rb" => "spec",
          "lib/helper.rb" => "helper"
        })

        stdout, _, _ = run_bin("git-changed-specs", chdir: repo)

        # Should only include spec files
        expect(stdout).to include("model_spec.rb")
        expect(stdout).not_to include("model.rb")
        expect(stdout).not_to include("helper.rb")
      end
    end

    it "returns empty when no spec files changed" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Add code only", files: {
          "app/model.rb" => "code",
          "lib/helper.rb" => "helper"
        })

        # grep returns exit 1 when no matches, but that's OK
        stdout, _, _ = run_bin("git-changed-specs", chdir: repo)

        expect(stdout.strip).to be_empty
      end
    end

    it "lists multiple changed spec files" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Add specs", files: {
          "spec/user_spec.rb" => "user spec",
          "spec/post_spec.rb" => "post spec",
          "spec/comment_spec.rb" => "comment spec"
        })

        stdout, _, _ = run_bin("git-changed-specs", chdir: repo)

        expect(stdout).to include("user_spec.rb")
        expect(stdout).to include("post_spec.rb")
        expect(stdout).to include("comment_spec.rb")
      end
    end
  end
end
