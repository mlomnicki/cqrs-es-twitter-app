module ReadModel
  module TestCase
    def setup
      @event_store = RailsEventStore::Client.new
      @redis       = Redis.new
      Setup.new(@event_store, @redis).init
    end

    attr_reader :event_store, :redis

    def publish(*events)
      events.each { |event| event_store.publish_event(event) }
    end
  end
end
