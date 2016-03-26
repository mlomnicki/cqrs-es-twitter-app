module ReadModel
  module TestCase
    def setup
      @event_store = RailsEventStore::Client.new
      @redis       = Redis.new
      Setup.new(@event_store, @redis).init
    end

    attr_reader :event_store, :redis
  end
end
