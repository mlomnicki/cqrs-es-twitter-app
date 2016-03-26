module AggregateRoot
  attr_reader :id

  def apply(event)
    apply_event(event)
    unpublished_events << event
  end

  def apply_old_event(event)
    apply_event(event)
  end

  def unpublished_events
    @unpublished_events ||= []
  end

  private
  attr_writer :id

  def apply_event(event)
    send("apply_#{event.class.name.demodulize.underscore.gsub('/', '_')}", event)
  end
end
