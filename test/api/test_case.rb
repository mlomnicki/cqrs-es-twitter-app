module Api
  module TestCase
    include Rack::Test::Methods

    def app
      Rails.application
    end
  end
end
