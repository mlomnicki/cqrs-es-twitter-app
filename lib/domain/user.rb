require "kernel/aggregate_root"

module Domain
  class User
    include AggregateRoot

    def initialize(id)
      @id    = id
      @state = :new
    end

    def sign_up(auth_info)
      apply Events::UserSignedUp.new(user_id: id, auth_info: auth_info)
    end

    private
    attr_reader :state

    def apply_user_signed_up(event)
      @state = :signed_up
    end
  end
end
