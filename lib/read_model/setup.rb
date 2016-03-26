module ReadModel
  class Setup
    attr_reader :event_store, :redis

    def initialize(event_store, redis)
      @event_store = event_store
      @redis       = redis
    end

    def init
      event_store.subscribe(Timeline.new(redis), [Events::TweetPublished])
    end
  end
end
