module CommandHandlers
  class FollowPerson < Handler
    def call(command)
      with_aggregate(command.follower_id) do |person|
        person.follow(command.person_to_follow_id)
      end
    end

    private
    def aggregate_class
      Domain::Follower
    end
  end
end
