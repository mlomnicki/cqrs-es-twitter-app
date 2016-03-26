require 'test_helper'

module CommandHandlers
  class PublishTweetTest < Minitest::Test
    include CommandHandlers::TestCase

    def test_publish_tweet
      tweet_id  = SecureRandom.uuid
      author_id = SecureRandom.uuid
      content   = "Hello world!"
      dispatch(
        Commands::PublishTweet.new(tweet_id: tweet_id, content: content, author_id: author_id)
      )
      assert_changes([
        Events::TweetPublished.new(tweet_id: tweet_id, content: content, author_id: author_id)
      ])
    end
  end
end
