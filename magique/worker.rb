module Magique
  module Worker
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def perform_now(*args)
        new.perform(*args)
      end

      def perform_async(*args)
        Magique.backend.push(worker: self, args: args)
      end
    end

    def perform(*)
      raise NotImplementedError
    end
  end
end
