module Adapters
  module EventStore
    class SqlRepository < RailsEventStoreActiveRecord::EventRepository
      def initialize
        @adapter = Event
      end
    end
  end
end
