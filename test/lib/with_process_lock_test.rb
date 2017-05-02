require 'test_helper'

class ProcessLockTest < MiniTest::Test

  def test_redis_key_available
    start = 1
    ProcessLock::WithProcessLock.execute_once('happy_test') do
      start += 1
    end
    assert_equal start, 2
    refute Redis.new.get('happy_test')
  end

  def test_redis_key_unavailable
    redis = Redis.new
    redis.set('sad_test', true)
    assert_equal(
      assert_raises(ProcessLock::ProcessLockError) do
        start = 1
        ProcessLock::WithProcessLock.execute_once('sad_test') do
          start += 1
        end
      end.message,
      'Can not run process because sad_test taken.'
    )
    assert Redis.new.get('sad_test')
  end

  class FakeException < RuntimeError
  end

  def test_block_exception_frees_key
    begin
      ProcessLock::WithProcessLock.execute_once('raises_exception') do
        raise FakeException
      end
    rescue FakeException => e
      assert(e)
    end
    refute Redis.new.get('raises_exception')
  end
end
