module CommandHandlers
  class ReplyToTweet < Handler
    def call(command)
      with_aggregate(command.tweet_id) do |tweet|
        tweet.reply(command.author_id, command.content)
      end
    end

    private
    def aggregate_class
      Domain::Tweet
    end
  end
end
