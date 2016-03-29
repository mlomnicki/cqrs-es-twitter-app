module Api
  module TestCase
    class HttpClient
      include Rack::Test::Methods

      def app
        Rails.application
      end
    end

    class ApiClient
      def initalize
        @http = HttpClient.new
      end

      def post(path, body)
        @http.post(path, body.to_json)
      end
    end
  end
end
