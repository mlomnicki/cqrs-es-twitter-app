module Types
  include Dry::Types.module

  UUID = String.constrained(format: /\A\w{8}(-\w{4}){3}-\w{12}?\z/i)
end
