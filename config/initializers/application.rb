redis       = Redis.new
event_store = EventStore.new(redis)

Rails.configuration.redis       = redis
Rails.configuration.application = Application.new(event_store.build)
