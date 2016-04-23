require "test_helper"

module ReadModel
  class TimelineTest < Minitest::Test
    include TestCase

    def test_timeline
      author_id = SecureRandom.uuid
      tweet1_id = SecureRandom.uuid
      tweet2_id = SecureRandom.uuid
      publish(
        Events::TweetPublished.new(tweet_id: tweet1_id, author_id: author_id, content: "Hello world"),
        Events::TweetPublished.new(tweet_id: tweet2_id, author_id: author_id, content: "Hello again")
      )
      assert_equal([tweet2_id, tweet1_id], redis.lrange("timeline:#{author_id}", 0, -1))
    end

    def test_tweet_details
      author_id = SecureRandom.uuid
      tweet_id  = SecureRandom.uuid
      content   = "Hello world"
      event     = Events::TweetPublished.new(tweet_id: tweet_id, author_id: author_id, content: content)
      publish(event)
      expected = {
        id:        tweet_id,
        author_id: author_id,
        content:   content,
        timestamp: event.timestamp,
      }.as_json
      assert_equal(expected, redis.hgetall("tweet:#{tweet_id}"))
    end
  end
end
