module Commands
  class PublishTweet < Command
    attribute :tweet_id,  Types::UUID
    attribute :author_id, Types::UUID
    attribute :content,   Types::String
  end
end
