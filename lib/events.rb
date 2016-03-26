require_relative "types"

module Events
  class Event < Dry::Types::Value
    def self.inherited(klass)
      super
      klass.constructor_type(:schema)
      klass.attribute :event_id,  Types::UUID.default     { SecureRandom.uuid }
      klass.attribute :timestamp, Types::DateTime.default { Time.now }
    end

    def to_h
      {
        event_id: event_id,
        data:     super.except(:event_id, :timestamp),
        metadata: { timestamp: timestamp }
      }
    end

    def data
      to_h[:data]
    end

    def ==(other_event)
      other_event.instance_of?(self.class) && other_event.data == data
    end
  end

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
