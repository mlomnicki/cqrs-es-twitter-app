module Domain
  class AuthInfo < Dry::Types::Value
    Providers = Types::Strict::String.enum('github')

    attribute :provider,    Providers
    attribute :provider_id, Types::String
    attribute :email,       Types::String
    attribute :username,    Types::String
    attribute :full_name,   Types::String
    attribute :raw_data,    Types::Hash
  end
end
