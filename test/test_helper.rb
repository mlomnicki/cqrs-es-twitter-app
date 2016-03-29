ENV["RAILS_ENV"] ||= "test"
$VERBOSE = false
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require_relative "lib/command_handlers/test_case"
require_relative "lib/read_model/test_case"
require_relative "api/test_case"

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
  provider: "github",
  uid:      "98765",
  info:     {
    email: "user@github.com"
  }
)

class FakeEventStore
  def initialize
    @events = []
    @published = []
  end

  attr_reader :events, :published

  def publish_event(event, aggregate_id)
    events << event
    published << event
  end

  def read_all_events(aggregate_id)
    events
  end
end

