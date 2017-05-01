require 'test_helper'

class ProcessLockTest < MiniTest::Test

  def test_redis_key_available
    start = 1
    ProcessLock::WithProcessLock.execute('happy_test') do
      start += 1
    end
    assert_equal start, 2
  end

  def test_redis_key_unavailable
    redis = Redis.new
    redis.set('sad_test', true)
    assert_raises StandardError do
      start = 1
      ProcessLock::WithProcessLock.execute('sad_test') do
        start += 1
      end
    end
  end
end
