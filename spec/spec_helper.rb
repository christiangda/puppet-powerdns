require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'codeclimate-test-reporter'
require 'simplecov'

RSpec.configure do |c|
  Puppet.settings[:strict_variables] = true if ENV['STRICT_VARIABLES'] == 'true'
  Puppet.settings[:ordering] = 'random' if ENV['ORDERING_RANDOM'] == 'true'
  c.parser = 'future' if ENV['FUTURE_PARSER'] == 'true'
  c.formatter = 'progress'
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start do
  add_filter '/.vendor/'
  add_filter '/vendor/'
  add_filter '/samples/'
  add_filter '/.bundle/'
  add_filter '/templates/'
  add_filter '/spec/fixtures/'
end

at_exit { RSpec::Puppet::Coverage.report! }

# CodeClimate::TestReporter.start
CodeClimate::TestReporter.configuration.profile
