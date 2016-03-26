module Events
  Event = Class.new(Dry::Types::Value)

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
