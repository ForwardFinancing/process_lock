require 'test_helper'

class ProcessLockTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ProcessLock::VERSION
  end
end
