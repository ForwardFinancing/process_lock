module ProcessLock
  module ExecuteOnce
    # Tries to run the given block and raises an exception if the process is
    # locked
    # @param key [String] The unique key to determine if the process is locked
    def execute_once(key, &blk)
      if can_execute?(key)
        execute(key, &blk)
      else
        redis.quit
        raise ProcessLockError, key: key
      end
    end
  end
end
