module ProcessLock
  class WithProcessLock
    def self.execute(key, &blk)
      if can_execute?(key)
        redis.set(key, true)
        yield blk
        redis.del(key)
        redis.quit
      else
        redis.quit
        raise StandardError, "Can not run process because #{key} taken."
      end
    end

    def self.can_execute?(key)
      !redis.exists(key)
    end

    def self.redis
      @_redis ||= Redis.new
    end
  end
end
