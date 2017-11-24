source 'https://rubygems.org'

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'metadata-json-lint'
  gem 'net-http-persistent', require: false if RUBY_VERSION >= '2.3.0'
  gem 'net-http-persistent', '2.9.4', require: false if RUBY_VERSION < '2.3.0'
  gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '>= 3.8.0'
  gem 'puppet-doc-lint'
  gem 'puppet-lint'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
  gem 'puppet-lint-empty_string-check'
  gem 'puppet-lint-file_ensure-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-undef_in_function-check'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-variable_contains_upcase'
  gem 'puppet-lint-version_comparison-check'
  gem 'puppet-syntax'
  gem 'puppetlabs_spec_helper'
  gem 'rake'
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-puppet'
  gem 'rspec-puppet-facts'
  gem 'rspec-puppet-utils'
  gem 'rubocop', require: false if RUBY_VERSION >= '2.0.0'
  gem 'rubocop-rspec', '~> 1.6', require: false if RUBY_VERSION >= '2.3.0'
  gem 'simplecov', require: false
end

group :development do
  gem 'puppet-blacksmith'
  gem 'travis'
  gem 'travis-lint'
end

group :acceptance do
  gem 'beaker', require: false if RUBY_VERSION >= '2.2.5'
  gem 'beaker-puppet_install_helper'
  gem 'beaker-rspec', require: false if RUBY_VERSION >= '2.2.5'
  gem 'serverspec'
end
