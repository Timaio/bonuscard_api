class UserResource < ApplicationResource
  has_many :cards
  many_to_many :shops

  attribute :email, :string
  attribute :negative_balance, :boolean
end
