require 'test_helper'

module CommandHandlers
  class FollowPersonTest < Minitest::Test
    include CommandHandlers::TestCase

    def test_follow_person
      person_id   = SecureRandom.uuid
      follower_id = SecureRandom.uuid
      dispatch(
        Commands::FollowPerson.new(person_to_follow_id: person_id, follower_id: follower_id)
      )
      assert_changes([
        Events::PersonFollowed.new(followed_person_id: person_id, follower_id: follower_id)
      ])
    end

    def test_cannot_follow_already_followed_person
      person_id   = SecureRandom.uuid
      follower_id = SecureRandom.uuid
      arrange(
        [Events::PersonFollowed.new(followed_person_id: person_id, follower_id: follower_id)]
      )
      error = assert_raises(Errors::DomainOperationError) do
        dispatch(Commands::FollowPerson.new(person_to_follow_id: person_id, follower_id: follower_id))
      end
      assert_equal "Person already followed", error.message
    end
  end
end
