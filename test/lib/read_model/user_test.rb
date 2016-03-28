require "test_helper"

module ReadModel
  class UserTest < Minitest::Test
    include TestCase

    def auth_info
      Domain::AuthInfo.new(
        provider:    "github",
        provider_id: "user-id-in-github",
        email:       "joe@example.com",
        username:    "jdoe",
        full_name:   "Joe Doe",
        raw_data:    { "avatar_url" => "http://example.com/avatar.png" }
      )
    end

    def test_sign_up
      user_id = SecureRandom.uuid
      publish(
        Events::UserSignedUp.new(user_id: user_id, auth_info: auth_info)
      )
      expected = {
        "username"  => auth_info.username,
        "full_name" => auth_info.full_name
      }
      assert_equal(expected, redis.hgetall("user:#{user_id}"))
      assert_equal([auth_info.email], redis.smembers("users:emails"))
    end
  end
end
