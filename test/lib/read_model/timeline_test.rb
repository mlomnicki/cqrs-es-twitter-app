require "test_helper"

module ReadModel
  class TimelineTest < Minitest::Test
    include TestCase

    def test_tweet_published
      author_id = SecureRandom.uuid
      content   = "Hello world"
      event     = Events::TweetPublished.new(author_id: author_id, content: content)
      event_store.publish_event(event)

      expected_content = {
        id:      event.event_id,
        content: content
      }.to_json
      assert_equal([expected_content], redis.smembers("timeline-#{author_id}"))
    end
  end
end
