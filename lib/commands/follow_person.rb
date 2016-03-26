module Commands
  class FollowPerson < Command
    attribute :person_to_follow_id, Types::UUID
    attribute :follower_id,         Types::UUID
  end
end
