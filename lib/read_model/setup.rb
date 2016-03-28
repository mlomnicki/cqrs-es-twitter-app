module ReadModel
  class Setup
    attr_reader :event_store, :redis

    def initialize(event_store, redis)
      @event_store = event_store
      @redis       = redis
    end

    def init
      event_store.subscribe(User.new(redis), [Events::UserSignedUp])
      event_store.subscribe(Timeline.new(redis), [Events::TweetPublished])
      event_store.subscribe(Followers.new(redis), [Events::PersonFollowed, Events::PersonUnfollowed])
    end
  end
end
