module Adapters
  module EventStore
    class Client
      def self.build
        RailsEventStore::Client.new(
          repository:   RailsEventStoreActiveRecord::EventRepository.new(adapter: Event),
          event_broker: RailsEventStore::EventBroker.new,
        )
      end
    end
  end
end
