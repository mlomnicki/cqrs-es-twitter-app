module ReadModel
  class Timeline
    def initialize(redis)
      @redis = redis
    end

    def handle_event(event)
      case event
      when Events::TweetPublished
        redis.hset("tweet:#{event.tweet_id}", :id,        event.tweet_id)
        redis.hset("tweet:#{event.tweet_id}", :author_id, event.author_id)
        redis.hset("tweet:#{event.tweet_id}", :content,   event.content)
        redis.hset("tweet:#{event.tweet_id}", :timestamp, event.timestamp.as_json)
        redis.lpush("timeline:#{event.author_id}", event.tweet_id)
      end
    end

    private
    attr_reader :redis
  end
end
