class SessionsController < ApplicationController
  def create
    dispatch_command(
      Commands::SignUp.new(
        user_id:   SecureRandom.uuid,
        auth_info: {
          provider:    auth_hash.provider,
          provider_id: auth_hash.uid,
          email:       auth_hash.info.email,
          username:    auth_hash.username,
          full_name:   auth_hash.name,
          raw_data:    auth_hash.to_h
        }
      )
    )
    redirect_to '/'
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
