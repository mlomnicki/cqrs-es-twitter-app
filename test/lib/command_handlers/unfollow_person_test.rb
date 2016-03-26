require 'test_helper'

module CommandHandlers
  class UnfollowPersonTest < Minitest::Test
    include CommandHandlers::TestCase

    def test_unfollow_person
      person_id   = SecureRandom.uuid
      follower_id = SecureRandom.uuid
      arrange(
        [Events::PersonFollowed.new(followed_person_id: person_id, follower_id: follower_id)]
      )
      dispatch(
        Commands::UnfollowPerson.new(person_to_unfollow_id: person_id, follower_id: follower_id)
      )
      assert_changes(
        [Events::PersonUnfollowed.new(unfollowed_person_id: person_id, follower_id: follower_id)]
      )
    end

    def test_cannot_unfollow_not_followed_person
      person_id   = SecureRandom.uuid
      follower_id = SecureRandom.uuid
      error = assert_raises(Errors::DomainOperationError) do
        dispatch(Commands::UnfollowPerson.new(person_to_unfollow_id: person_id, follower_id: follower_id))
      end
      assert_equal "Person not followed", error.message
    end
  end
end
