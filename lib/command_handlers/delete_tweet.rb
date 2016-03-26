module CommandHandlers
  class DeleteTweet < Handler
    def call(command)
      with_aggregate(command.tweet_id) do |tweet|
        tweet.delete
      end
    end

    private
    def aggregate_class
      Domain::Tweet
    end
  end
end
