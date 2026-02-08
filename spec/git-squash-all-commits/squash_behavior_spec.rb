# frozen_string_literal: true

require "spec_helper"

RSpec.describe "git-squash-all-commits" do
  describe "squashing commits" do
    it "squashes all commits on the branch into one" do
      with_test_repo do |repo|
        # Create a feature branch with multiple commits
        create_branch(repo, "feature")
        create_commit(repo, message: "Feature commit 1", files: { "f1.txt" => "1" })
        create_commit(repo, message: "Feature commit 2", files: { "f2.txt" => "2" })
        create_commit(repo, message: "Feature commit 3", files: { "f3.txt" => "3" })

        # Count commits before squash (should be 4: initial + 3 feature)
        _count_before, _, _ = run_command("git rev-list --count HEAD", chdir: repo)

        # Squash with a message
        stdout, _stderr, status = run_bin("git-squash-all-commits", "Combined feature", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("Squashing")
        expect(stdout).to include("squashed into one")

        # Count commits after squash (should be 2: initial + 1 squashed)
        count_after, _, _ = run_command("git rev-list --count HEAD", chdir: repo)
        expect(count_after.strip.to_i).to eq(2)

        # Check the commit message
        msg, _, _ = run_command("git log -1 --format=%s", chdir: repo)
        expect(msg.strip).to eq("Combined feature")

        # All files should still exist
        expect(File.exist?(File.join(repo, "f1.txt"))).to be true
        expect(File.exist?(File.join(repo, "f2.txt"))).to be true
        expect(File.exist?(File.join(repo, "f3.txt"))).to be true
      end
    end

    it "preserves file changes after squash" do
      with_test_repo do |repo|
        create_branch(repo, "feature")
        create_commit(repo, message: "Add file", files: { "data.txt" => "important data" })
        create_commit(repo, message: "Modify file", files: { "data.txt" => "updated data" })

        run_bin("git-squash-all-commits", "Squashed", chdir: repo)

        content = File.read(File.join(repo, "data.txt"))
        expect(content).to eq("updated data")
      end
    end

    it "reports when nothing to squash" do
      with_test_repo do |repo|
        # On main with no additional commits
        stdout, _, status = run_bin("git-squash-all-commits", chdir: repo)

        expect(status).to eq(0)
        expect(stdout).to include("No commits to squash")
      end
    end
  end

  describe "error handling" do
    it "fails when not in a git repository" do
      Dir.mktmpdir("not-a-repo-") do |tmpdir|
        _stdout, _stderr, status = run_bin("git-squash-all-commits", chdir: tmpdir)

        expect(status).not_to eq(0)
      end
    end
  end
end
