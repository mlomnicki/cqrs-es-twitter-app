require_relative 'sql_repository'

module Adapters
  module EventStore
    class Client
      def self.build
        RailsEventStore::Client.new(
          repository:   SqlRepository.new,
          event_broker: RailsEventStore::EventBroker.new,
        )
      end
    end
  end
end
