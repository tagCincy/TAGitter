require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.start 'rails' do
  add_filter '/vendor/'
  add_filter '/bin/'
  add_filter '/lib/'
  add_filter '/app/views/'
  minimum_coverage_by_file 80
end

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

end
