require "kernel/aggregate_root"

module Domain
  class Tweet
    include AggregateRoot

    def initialize(id)
      @id    = id
      @state = :unpublished
    end

    def publish(author_id, content)
      apply Events::TweetPublished.new(tweet_id: id, author_id: author_id, content: content)
    end

    def reply(author_id, content)
      check_if_published
      apply Events::ReplyToTweetPosted.new(tweet_id: id, author_id: author_id, content: content)
    end

    def delete
      check_if_published
      apply Events::TweetDeleted.new(tweet_id: id)
    end

    private
    attr_accessor :state

    def apply_tweet_published(event)
      @state = :published
    end

    def apply_reply_to_tweet_posted(event)
    end

    def apply_tweet_deleted(event)
      @state = :deleted
    end

    def check_if_published
      raise(Errors::DomainOperationError, "Tweet is not published") if state != :published
    end
  end
end
