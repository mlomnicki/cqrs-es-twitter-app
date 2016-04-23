class ApplicationController < ActionController::API
  def dispatch_command(command)
    Rails.configuration.application.dispatch(command)
  end

  def redis
    Rails.configuration.redis
  end
end
