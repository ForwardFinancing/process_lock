module ProcessLock
  class ProcessLockError < StandardError
    def initialize(key:)
      super("Can not run process because #{key} taken.")
    end
  end
end
