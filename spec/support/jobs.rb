class TestJob
  extend Resque::Plugins::Remora
  @queue = :test

  class << self
    def perform
    end
  
    def attach_remora
      {:time => Time.now.to_i}
    end
  
    def process_remora(queue, information)
      Resque.redis.set("queue", queue)
      Resque.redis.set("time", information['time'])
      Resque.redis.set(information['time'], "true")
    end
  end
end

class NotRemoraTestJob
  @queue = :not_remora

  def self.perform
  end
end