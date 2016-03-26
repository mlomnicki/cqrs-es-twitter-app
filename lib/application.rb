require 'aggregate_root/repository'

class Application
  def initialize(event_store)
    @event_store = event_store
    @repository  = AggregateRoot::Repository.new(event_store)
    @command_bus = CommandBus.new
    register_handlers
  end

  def dispatch(command)
    command_bus.call(command)
  end

  private
  attr_reader :event_store, :repository, :command_bus

  def register_handlers
    command_handlers.each do |command, handler|
      command_bus.register(command, handler)
    end
  end

  def command_handlers
    {
      Commands::PublishTweet => CommandHandlers::PublishTweet.new(repository),
      Commands::ReplyToTweet => CommandHandlers::ReplyToTweet.new(repository),
      Commands::DeleteTweet  => CommandHandlers::DeleteTweet.new(repository),
    }
  end
end
