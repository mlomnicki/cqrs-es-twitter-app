module Commands
  class DeleteTweet < Command
    attribute :tweet_id,  Types::UUID
  end
end
