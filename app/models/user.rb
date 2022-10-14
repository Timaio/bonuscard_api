class User < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :shops, through: :cards

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
