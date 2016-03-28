require 'test_helper'

module CommandHandlers
  class SignUpTest < Minitest::Test
    include CommandHandlers::TestCase

    def build_auth_info
      Domain::AuthInfo.new(
        provider:    "github",
        provider_id: SecureRandom.uuid,
        email:       "joe@example.com",
        username:    "jdoe",
        full_name:   "Joe Doe",
        raw_data:    { "avatar_url" => "http://example.com/avatar.png" }
      )
    end

    def test_sign_up
      user_id   = SecureRandom.uuid
      auth_info = build_auth_info
      dispatch(
        Commands::SignUp.new(user_id: user_id, auth_info: auth_info)
      )
      assert_changes([
        Events::UserSignedUp.new(user_id: user_id, auth_info: auth_info)
      ])
    end
  end
end
