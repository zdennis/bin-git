# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require "open3"

# Root directory where the bin scripts live
BIN_DIR = File.expand_path("../bin", __dir__)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  config.default_formatter = "doc" if config.files_to_run.one?

  config.order = :random
  Kernel.srand config.seed
end

# Helper module for running commands and managing test git repositories
module CommandHelper
  # Run a command and return [stdout, stderr, exit_status]
  # Automatically includes BIN_DIR in PATH so scripts can call each other
  def run_command(command, chdir: nil, env: {})
    options = {}
    options[:chdir] = chdir if chdir

    # Ensure BIN_DIR is in PATH so scripts can call other bin scripts
    env_with_path = { "PATH" => "#{BIN_DIR}:#{ENV['PATH']}" }.merge(env)

    stdout, stderr, status = Open3.capture3(env_with_path, command, **options)
    [stdout, stderr, status.exitstatus]
  end

  # Run a bin script by name
  def run_bin(script_name, *args, chdir: nil, env: {})
    script_path = File.join(BIN_DIR, script_name)
    command = ([script_path] + args).map { |a| shell_escape(a) }.join(" ")
    run_command(command, chdir: chdir, env: env)
  end

  # Shell escape a string
  def shell_escape(str)
    str = str.to_s
    return "''" if str.empty?
    return str if str =~ /\A[A-Za-z0-9_\-.,:+\/@]+\z/

    "'" + str.gsub("'", "'\\''") + "'"
  end
end

# Helper module for creating and managing test git repositories
module GitRepoHelper
  include CommandHelper

  # Create a temporary git repository and yield its path
  # The repository is automatically cleaned up after the block
  def with_test_repo(name: "test-repo")
    Dir.mktmpdir("git-helpers-test-") do |tmpdir|
      repo_path = File.join(tmpdir, name)
      FileUtils.mkdir_p(repo_path)

      # Initialize git repo with initial commit
      run_command("git init", chdir: repo_path)
      run_command("git config user.email 'test@example.com'", chdir: repo_path)
      run_command("git config user.name 'Test User'", chdir: repo_path)

      # Create initial commit so we have a valid HEAD
      File.write(File.join(repo_path, "README.md"), "# Test Repository\n")
      run_command("git add README.md", chdir: repo_path)
      run_command("git commit -m 'Initial commit'", chdir: repo_path)

      yield repo_path
    end
  end

  # Create a commit in the repo with the given message and optional file changes
  def create_commit(repo_path, message:, files: {})
    files.each do |filename, content|
      file_path = File.join(repo_path, filename)
      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, content)
      run_command("git add #{shell_escape(filename)}", chdir: repo_path)
    end

    if files.empty?
      # Create a dummy change if no files specified
      timestamp = Time.now.to_f.to_s
      File.write(File.join(repo_path, ".timestamp"), timestamp)
      run_command("git add .timestamp", chdir: repo_path)
    end

    run_command("git commit -m #{shell_escape(message)}", chdir: repo_path)
  end

  # Get the SHA of HEAD
  def head_sha(repo_path, short: false)
    format = short ? "--short" : ""
    stdout, _, _ = run_command("git rev-parse #{format} HEAD", chdir: repo_path)
    stdout.strip
  end

  # Create a branch
  def create_branch(repo_path, branch_name)
    run_command("git checkout -b #{shell_escape(branch_name)}", chdir: repo_path)
  end

  # Switch to a branch
  def checkout_branch(repo_path, branch_name)
    run_command("git checkout #{shell_escape(branch_name)}", chdir: repo_path)
  end

  # Get current branch name
  def current_branch(repo_path)
    stdout, _, _ = run_command("git rev-parse --abbrev-ref HEAD", chdir: repo_path)
    stdout.strip
  end
end

RSpec.configure do |config|
  config.include CommandHelper
  config.include GitRepoHelper
end
