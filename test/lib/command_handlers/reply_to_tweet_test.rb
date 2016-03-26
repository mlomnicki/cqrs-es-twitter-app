require 'test_helper'

module CommandHandlers
  class ReplyToTweetTest < Minitest::Test
    include CommandHandlers::TestCase

    def test_reply_to_tweet
      tweet_id   = SecureRandom.uuid
      replier_id = SecureRandom.uuid
      content    = "@author +1"
      arrange([
        Events::TweetPublished.new(tweet_id: tweet_id, content: "CQRS + ES", author_id: SecureRandom.uuid)
      ])
      dispatch(
        Commands::ReplyToTweet.new(tweet_id: tweet_id, content: content, author_id: replier_id)
      )
      assert_changes([
        Events::ReplyToTweetPosted.new(tweet_id: tweet_id, content: content, author_id: replier_id)
      ])
    end

    def test_cannot_reply_to_deleted_tweet
      tweet_id = SecureRandom.uuid
      arrange([
        Events::TweetPublished.new(tweet_id: tweet_id, content: "CQRS + ES", author_id: SecureRandom.uuid),
        Events::TweetDeleted.new(tweet_id: tweet_id),
      ])
      error = assert_raises(Errors::DomainOperationError) do
        dispatch(Commands::ReplyToTweet.new(tweet_id: tweet_id, content: "+1", author_id: SecureRandom.uuid))
      end
      assert_equal "Tweet is not published", error.message
    end

  end
end
