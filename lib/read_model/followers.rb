module ReadModel
  class Followers
    def initialize(redis)
      @redis = redis
    end

    def handle_event(event)
      case event
      when Events::PersonFollowed
        redis.zadd("following:#{event.follower_id}",        event.timestamp.to_f, event.followed_person_id)
        redis.zadd("followers:#{event.followed_person_id}", event.timestamp.to_f, event.follower_id)
      when Events::PersonUnfollowed
        redis.zrem("following:#{event.follower_id}",          event.unfollowed_person_id)
        redis.zrem("followers:#{event.unfollowed_person_id}", event.follower_id)
      end
    end

    private
    attr_reader :redis
  end
end
