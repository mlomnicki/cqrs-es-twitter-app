module Adapters
  module EventStore
    class Event < ActiveRecord::Base
      self.table_name = "event_store_events"
    end
  end
end
