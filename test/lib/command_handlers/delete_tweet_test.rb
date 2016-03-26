require 'test_helper'

module CommandHandlers
  class DeleteTweetTest < Minitest::Test
    include CommandHandlers::TestCase

    def test_delete_tweet
      tweet_id  = SecureRandom.uuid
      author_id = SecureRandom.uuid
      arrange([
        Events::TweetPublished.new(tweet_id: tweet_id, content: "CQRS + ES", author_id: author_id)
      ])
      dispatch(
        Commands::DeleteTweet.new(tweet_id: tweet_id, author_id: author_id)
      )
      assert_changes([
        Events::TweetDeleted.new(tweet_id: tweet_id)
      ])
    end

    def test_cannot_delete_already_deleted_tweet
      tweet_id = SecureRandom.uuid
      arrange([
        Events::TweetPublished.new(tweet_id: tweet_id, content: "CQRS + ES", author_id: SecureRandom.uuid),
        Events::TweetDeleted.new(tweet_id: tweet_id),
      ])
      error = assert_raises(Errors::DomainOperationError) do
        dispatch(Commands::DeleteTweet.new(tweet_id: tweet_id))
      end
      assert_equal "Tweet is not published", error.message
    end
  end
end
