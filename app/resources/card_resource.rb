class CardResource < ApplicationResource
  belongs_to :user
  belongs_to :shop

  attribute :bonuses, :integer

  attribute :user_id, :integer, only: [:filterable]
  attribute :shop_id, :integer, only: [:filterable]

  stat bonuses: [:sum]
end
