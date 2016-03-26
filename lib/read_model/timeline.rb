module ReadModel
  class Timeline
    def initialize(redis)
      @redis = redis
    end

    def handle_event(event)
      case event
      when Events::TweetPublished
        redis.sadd("timeline-#{event.author_id}", { id: event.event_id, content: event.content }.to_json)
      end
    end

    private
    attr_reader :redis
  end
end
