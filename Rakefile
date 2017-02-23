require 'rubygems'
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'
require 'rubocop/rake_task'

begin
  require 'puppet_blacksmith/rake_tasks'

  Blacksmith::RakeTask.new do |t|
    t.tag_pattern = 'v%s' # Use a custom pattern with git tag. %s is replaced with the version number.
    t.build = false # do not build the module nor push it to the Forge, just do the tagging [:clean, :tag, :bump_commit]
  end

rescue LoadError
  puts 'ignoring group :development'
end

begin
  require 'beaker/tasks/quick_start'
rescue LoadError
  puts 'ignoring group :acceptance'
end

exclude_paths = [
  'pkg/**/*',
  'vendor/**/*',
  '.vendor/**/*',
  'spec/**/*'
]

log_format = '%{path}:%{linenumber}:%{check}:%{KIND}:%{message}'

PuppetLint::RakeTask.new(:lint) do |config|
  config.disable_checks = ['disable_80chars']
  config.fail_on_warnings = true
  config.with_context = true
  config.ignore_paths = exclude_paths
  config.log_format = log_format
end

RSpec::Core::RakeTask.new(:spec_verbose) do |t|
  t.pattern = 'spec/{classes,defines,lib,reports}/**/*_spec.rb'
  t.rspec_opts = [
    '--format documentation',
    '--color'
  ]
end

RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

RuboCop::RakeTask.new

task test: [
  :rubocop,
  :metadata_lint,
  :syntax,
  :lint,
  :validate,
  :spec
]

# task default: test:
