event_store = RailsEventStore::Client.new
Rails.configuration.application = Application.new(event_store)
