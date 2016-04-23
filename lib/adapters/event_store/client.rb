module Adapters
  module EventStore
    class Client
      def self.build
        RailsEventStore::Client.new(
          repository: RailsEventStoreActiveRecord::EventRepository.new(adapter: Event)
        )
      end
    end
  end
end
