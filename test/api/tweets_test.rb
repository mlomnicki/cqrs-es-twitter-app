require "test_helper"

module Api
  class TweetsTest < Minitest::Test
    include TestCase

    def test_publish_tweet
      tweet_id = SecureRandom.uuid
      user_id  = SecureRandom.uuid
      client   = HttpClient.new
      client.post("/tweets", id: tweet_id, content: "Hello world!", user_id: user_id)
      assert_equal 204, client.last_response.status
    end

    def test_timeline
      client   = HttpClient.new
      user_id  = SecureRandom.uuid
      contents = [
        "My first tweet",
        "My second tweet"
      ]
      client.post("/tweets", id: SecureRandom.uuid, content: contents[0], user_id: user_id)
      client.post("/tweets", id: SecureRandom.uuid, content: contents[1], user_id: user_id)
      response = client.get("/tweets/user/#{user_id}")
      assert_equal contents.reverse, JSON.parse(response.body).map { |tweet| tweet["content"] }
    end

    def test_tweet
      client   = HttpClient.new
      tweet_id = SecureRandom.uuid
      content  = "Hello world"
      client.post("/tweets", id: tweet_id, content: content, user_id: SecureRandom.uuid)
      response = client.get("/tweets/#{tweet_id}")
      assert_equal content, JSON.parse(response.body)["content"]
    end
  end
end
