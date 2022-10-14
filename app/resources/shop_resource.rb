class ShopResource < ApplicationResource
  has_many :cards
  many_to_many :users

  attribute :name, :string
end
