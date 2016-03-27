require "test_helper"

module ReadModel
  class TimelineTest < Minitest::Test
    include TestCase

    def test_timeline
      author_id = SecureRandom.uuid
      event1    = Events::TweetPublished.new(author_id: author_id, content: "Hello world")
      event2    = Events::TweetPublished.new(author_id: author_id, content: "Hello again")
      publish(event1, event2)
      assert_equal([event2.event_id, event1.event_id], redis.lrange("timeline:#{author_id}", 0, -1))
    end

    def test_tweet_details
      author_id = SecureRandom.uuid
      event     = Events::TweetPublished.new(author_id: author_id, content: "Hello world")
      publish(event)
      expected = {
        "author_id" => author_id,
        "content"   => event.content,
        "timestamp" => event.timestamp.as_json
      }
      assert_equal(expected, redis.hgetall("tweet:#{event.event_id}"))
    end
  end
end
