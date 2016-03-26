require "kernel/aggregate_root"

module Domain
  class Follower
    include AggregateRoot

    def initialize(id)
      @id              = id
      @followed_people = Set.new
    end

    def follow(person_id)
      check_if_can_follow(person_id)
      apply Events::PersonFollowed.new(follower_id: id, followed_person_id: person_id)
    end

    def unfollow(person_id)
      check_if_can_unfollow(person_id)
      apply Events::PersonUnfollowed.new(follower_id: id, unfollowed_person_id: person_id)
    end

    private
    attr_reader :followed_people

    def apply_person_followed(event)
      followed_people << event.followed_person_id
    end

    def apply_person_unfollowed(event)
      followed_people.delete(event.unfollowed_person_id)
    end

    def check_if_can_follow(person_id)
      raise(Errors::DomainOperationError, "Person already followed") if followed_people.include?(person_id)
    end

    def check_if_can_unfollow(person_id)
      raise(Errors::DomainOperationError, "Person not followed") unless followed_people.include?(person_id)
    end
  end
end
