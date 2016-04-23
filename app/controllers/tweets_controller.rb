class TweetsController < ApplicationController
  def publish_tweet
    dispatch_command(
      Commands::PublishTweet.new(
        tweet_id:  params[:id],
        author_id: params[:user_id],
        content:   params[:content]
      )
    )
  end

  def show_tweet
    render json: redis.hgetall("tweet:#{params[:id]}")
  end

  def show_tweets_of_user
    tweets = redis.lrange("timeline:#{params[:user_id]}", 0, 100).map do |tweet_id|
      redis.hgetall("tweet:#{tweet_id}")
    end
    render json: tweets
  end
end
