module ReadModel
  class User
    def initialize(redis)
      @redis = redis
    end

    def handle_event(event)
      case event
      when Events::UserSignedUp
        redis.hset("user:#{event.user_id}", :username,  event.auth_info.username)
        redis.hset("user:#{event.user_id}", :full_name, event.auth_info.full_name)
      end
    end

    private
    attr_reader :redis
  end
end
