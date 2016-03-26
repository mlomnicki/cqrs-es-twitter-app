module Commands
  class UnfollowPerson < Command
    attribute :person_to_unfollow_id, Types::UUID
    attribute :follower_id,           Types::UUID
  end
end
