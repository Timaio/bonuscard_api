class Card < ApplicationRecord
  MIN_AMOUNT_TO_ADD_BONUSES = 100
  BONUS_PERCENTAGE = 0.01

  belongs_to :user
  belongs_to :shop

  validates :user, presence: true
  validates :shop, presence: true
  validates :user_id, uniqueness: { scope: :shop_id }

  def update_bonuses(amount, use_bonuses)
    amount_due = nil
    remaining_bonus = self.bonuses

    if use_bonuses
      # Withdraw bonuses

      user = self.user

      if user.negative_balance
        all_cards_bonuses = user.cards.sum(:bonuses)

        if all_cards_bonuses <= amount
          amount_due = amount.round(half: :up) - all_cards_bonuses
          remaining_bonus -= all_cards_bonuses
        else
          amount_due = 0
          remaining_bonus -= amount.round(half: :up)
        end
      else
        if remaining_bonus <= amount
          amount_due = amount.round(half: :up) - remaining_bonus
          remaining_bonus = 0
        else
          amount_due = 0
          remaining_bonus -= amount.round(half: :up)
        end
      end

      remaining_bonus += (amount_due * BONUS_PERCENTAGE).to_i
    else
      # Add bonuses

      remaining_bonus += (amount * BONUS_PERCENTAGE).to_i
      amount_due = amount
    end

    self.update(bonuses: remaining_bonus)

    return {
      amount_due: amount_due,
      remaining_bonus: remaining_bonus
    }
  end
end
