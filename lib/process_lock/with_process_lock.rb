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
        @_redis ||= Redis.new(ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
      end
    end
  end
end
