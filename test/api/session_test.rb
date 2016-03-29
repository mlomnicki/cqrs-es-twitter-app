require "test_helper"

module Api
  class SessionTest < Minitest::Test
    include TestCase

    def test_sign_up
      client = HttpClient.new
      client.get '/auth/github'
      assert client.last_response.redirect?
      client.follow_redirect!
      assert_equal "http://example.org/", client.last_response.location
    end
  end
end
