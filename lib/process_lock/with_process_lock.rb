module ProcessLock
  class WithProcessLock
    class << self
      include ExecuteOnce
      include ExecuteWithRetry

      private

      def execute(key, &blk)
        redis.set(key, true)
        yield blk
      ensure
        # Delete the key and quit redis even if the block raises an exception
        redis.del(key)
        redis.quit
      end

      def can_execute?(key)
        !redis.exists(key)
      end

      def redis
        @_redis ||= Redis.new
      end
    end
  end
end
