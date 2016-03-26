module Events
  Event = Class.new(Dry::Types::Value)

  class PersonFollowed < Event
    attribute :follower_id,        Types::UUID
    attribute :followed_person_id, Types::UUID
  end

  class PersonUnfollowed < Event
    attribute :follower_id,          Types::UUID
    attribute :unfollowed_person_id, Types::UUID
  end

  class TweetPublished < Event
    attribute :author_id, Types::UUID
    attribute :tweet_id,  Types::UUID
    attribute :content,   Types::String
  end

  class ReplyToTweetPosted < Event
    attribute :tweet_id,  Types::UUID
    attribute :author_id, Types::UUID
    attribute :content,   Types::String
  end

  class TweetDeleted < Event
    attribute :tweet_id, Types::UUID
  end
end
