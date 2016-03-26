module CommandHandlers
  class UnfollowPerson < Handler
    def call(command)
      with_aggregate(command.follower_id) do |person|
        person.unfollow(command.person_to_unfollow_id)
      end
    end

    private
    def aggregate_class
      Domain::Follower
    end
  end
end
