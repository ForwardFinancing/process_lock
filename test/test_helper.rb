$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'codeclimate-test-reporter'
SimpleCov.minimum_coverage 100
SimpleCov.start do
  add_filter '/test'
end

require 'process_lock'

require 'minitest/autorun'
require 'pry'

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

require "minitest/reporters"
Minitest::Reporters.use!
