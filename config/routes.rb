Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#create"

  namespace :tweets do
    post "/",             action: :publish_tweet
    get  ":id",           action: :show_tweet
    get  "user/:user_id", action: :show_tweets_of_user
  end
end
