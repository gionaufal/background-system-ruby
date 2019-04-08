module Magique
  class Processor
    def self.start(concurrency = 1)
      concurrency.times { |n| new("Processor #{n}") }
    end

    def initialize(name)
      thread = Thread.new do
        loop do
          payload = Magique.backend.pop
          worker_class = payload[:worker]
          worker_class.new.perform(*payload[:args])
        end
      end

      thread.name = name
    end
  end
end
