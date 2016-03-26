module CommandHandlers
  module TestCase
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

    def setup
      @event_store = FakeEventStore.new
      @application = Application.new(@event_store)
    end

    attr_reader :event_store

    def arrange(events)
      event_store.events.push(*events)
    end

    def dispatch(command)
      @application.dispatch(command)
    end

    def assert_changes(expected_events)
      assert_equal(expected_events, event_store.published)
    end
  end
end
