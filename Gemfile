source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :rake, :test do
  gem 'rake', '~> 10.4.0',      :require => false
  gem 'rspec', '~> 3.0',        :require => false
  gem 'rspec-core',             :require => false
  gem 'rspec-puppet',           :require => false
  gem 'puppetlabs_spec_helper', :require => false
end

group :rake, :development do
  gem 'travis',            :require => false
  gem 'travis-lint',       :require => false
  gem 'puppet-syntax',     :require => false
  gem 'puppet-blacksmith', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '~> 3.7.0', :require => false
end
