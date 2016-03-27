require "test_helper"

module ReadModel
  class FollowersTest < Minitest::Test
    include TestCase

    def test_following
      follower_id         = SecureRandom.uuid
      followed_person1_id = SecureRandom.uuid
      followed_person2_id = SecureRandom.uuid
      followed_person3_id = SecureRandom.uuid
      publish(
        Events::PersonFollowed.new(follower_id: follower_id, followed_person_id: followed_person1_id),
        Events::PersonFollowed.new(follower_id: follower_id, followed_person_id: followed_person2_id),
        Events::PersonFollowed.new(follower_id: follower_id, followed_person_id: followed_person3_id),
        Events::PersonUnfollowed.new(follower_id: follower_id, unfollowed_person_id: followed_person2_id)
      )
      assert_equal([followed_person1_id, followed_person3_id], redis.zrange("following:#{follower_id}", 0, -1))
    end

    def test_followers
      follower1_id = SecureRandom.uuid
      follower2_id = SecureRandom.uuid
      follower3_id = SecureRandom.uuid
      person_id    = SecureRandom.uuid
      publish(
        Events::PersonFollowed.new(follower_id: follower1_id, followed_person_id: person_id),
        Events::PersonFollowed.new(follower_id: follower2_id, followed_person_id: person_id),
        Events::PersonFollowed.new(follower_id: follower3_id, followed_person_id: person_id),
        Events::PersonUnfollowed.new(follower_id: follower2_id, unfollowed_person_id: person_id)
      )
      assert_equal([follower1_id, follower3_id], redis.zrange("followers:#{person_id}", 0, -1))
    end
  end
end
