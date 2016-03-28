module Commands
  class SignUp < Command
    attribute :user_id,   Types::UUID
    attribute :auth_info, Domain::AuthInfo
  end
end
