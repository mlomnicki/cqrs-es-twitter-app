secrets = Rails.application.secrets
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, secrets.github_key, secrets.github_secret
end
