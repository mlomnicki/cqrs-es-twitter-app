module Commands
  class ReplyToTweet < Command
    attribute :tweet_id,  Types::UUID
    attribute :author_id, Types::UUID
    attribute :content,   Types::String
  end
end
