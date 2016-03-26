module CommandHandlers
  class PublishTweet < Handler
    def call(command)
      with_aggregate(command.tweet_id) do |tweet|
        tweet.publish(command.author_id, command.content)
      end
    end

    private
    def aggregate_class
      Domain::Tweet
    end
  end
end
