class EventStore
  def initialize(redis)
    @redis = redis
  end

  def build
    RailsEventStore::Client.new.tap do |es|
      es.subscribe(ReadModel::Timeline.new(@redis), [Events::TweetPublished])
    end
  end
end
