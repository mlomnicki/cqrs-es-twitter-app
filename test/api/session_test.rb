require "test_helper"

module Api
  class SessionTest < Minitest::Test
    include TestCase

    def test_sign_up
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      get '/auth/github'
      assert last_response.redirect?
      follow_redirect!
      assert_equal "http://example.org/", last_response.location
    end
  end
end
