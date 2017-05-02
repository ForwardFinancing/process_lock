require 'test_helper'

class ExecuteWithRetryTest < MiniTest::Test
  def test_it_works_the_first_time
    i = 1
    ProcessLock::WithProcessLock.execute_with_retry('test') do
      i += 1
    end
    assert_equal i, 2
  end

  def test_blocked_the_first_time_then_works
    i = 1
    # Set the key so process is locked
    Redis.new.set('test', true)
    a = Thread.new do
      # In this thread, the process should still be locked, so i should not be
      # incremented, and we unlock the process
      sleep(0.01)
      Redis.new.del('test')
      assert_equal(i, 1)
    end
    b = Thread.new do
      # In this thread, the process should be unlocked by the previous shorter
      # thread. I should be incremented
      sleep(0.03)
      assert_equal(i, 2)
    end
    ProcessLock::WithProcessLock.execute_with_retry('test', retry_wait: 0.01) do
      i += 1
    end
    a.join
    b.join
    assert_equal(i, 2)
  end

  def test_blocked_then_times_out
    i = 1
    # Set the key so process is locked
    Redis.new.set('test', true)
    assert_equal(
      assert_raises(StandardError) do
        ProcessLock::WithProcessLock.execute_with_retry(
          'test',
          retry_wait: 0.01,
          timeout: 0.02
        ) do
          i += 1
        end
      end.message,
      'Can not run process because test taken.'
    )

    # We never unlock the process, so it should timeout without incrementing
    assert_equal(i, 1)
  end
end
