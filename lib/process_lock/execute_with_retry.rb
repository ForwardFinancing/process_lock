module ProcessLock
  module ExecuteWithRetry
    # Tries to run the given block and retries every retry_wait seconds until
    #   the process in unblocked
    # @param key [String] The unique key to determine if the process is locked
    # @param retry_wait [Number] The number of seconds to wait in between
    #   retry attempts, defaulting to 1
    # @param timeout [Number] The number of seconds until an exception should
    #   be raised instead of retrying, defaulting to nil (no timeout)
    def execute_with_retry(
      key,
      retry_wait: 1,
      timeout: nil,
      &blk
    )
      if can_execute?(key)
        execute(key, &blk)
      else
        # If there is time left before timeout or there is no timeout,
        # wait retry_wait seconds and then recurse
        if timeout.nil? || timeout >= retry_wait
          sleep(retry_wait)
          execute_with_retry(
            key,
            retry_wait: retry_wait,
            timeout: timeout.nil? ? nil : timeout - retry_wait,
            &blk
          )
        else
          # If the timeout was reached, give up
          redis.quit
          raise ProcessLockError, key: key
        end
      end
    end
  end
end
