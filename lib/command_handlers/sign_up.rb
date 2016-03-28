module CommandHandlers
  class SignUp < Handler
    def call(command)
      with_aggregate(command.user_id) do |user|
        user.sign_up(command.auth_info)
      end
    end

    private
    def aggregate_class
      Domain::User
    end
  end
end
