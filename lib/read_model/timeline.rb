module ReadModel
  class Timeline
    def initialize(redis)
      @redis = redis
    end

    def handle_event(event)
      case event
      when Events::TweetPublished
        redis.hset("tweet:#{event.event_id}", :author_id, event.author_id)
        redis.hset("tweet:#{event.event_id}", :content,   event.content)
        redis.hset("tweet:#{event.event_id}", :timestamp, event.timestamp.as_json)
        redis.lpush("timeline:#{event.author_id}", event.event_id)
      end
    end

    private
    attr_reader :redis
  end
end
