class Card < ApplicationRecord
  MIN_AMOUNT_TO_ADD_BONUSES = 100
  BONUS_PERCENTAGE = 0.01

  belongs_to :user
  belongs_to :shop

  validates :user, presence: true
  validates :shop, presence: true
  validates :user_id, uniqueness: { scope: :shop_id }

  def update_bonuses(amount, use_bonuses)
    amount_due = amount
    remaining_bonus = self.bonuses

    if use_bonuses
      # Withdraw bonuses

      user = self.user

      if user.negative_balance
        all_cards_bonuses = user.cards.sum(:bonuses)

        if all_cards_bonuses <= amount
          amount_due -= all_cards_bonuses
          remaining_bonus -= all_cards_bonuses
        else
          amount_due = 0
          remaining_bonus -= amount
        end
      else
        if remaining_bonus <= amount
          amount_due -= remaining_bonus
          remaining_bonus = 0
        else
          amount_due = 0
          remaining_bonus -= amount
        end
      end
    else
      # Add bonuses

      if amount >= MIN_AMOUNT_TO_ADD_BONUSES
        remaining_bonus += (amount * BONUS_PERCENTAGE).to_i
      end
    end

    self.update(bonuses: remaining_bonus)

    return {
      amount_due: amount_due,
      remaining_bonus: remaining_bonus
    }
  end
end
