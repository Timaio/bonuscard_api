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

    # Withdraw bonuses
    if use_bonuses
      user = self.user

      bonus_balance = user.negative_balance ? user.cards.sum(:bonuses) : remaining_bonus

      if bonus_balance <= amount
        if bonus_balance > 0
          amount_due = amount.round(half: :up) - bonus_balance
        end

        remaining_bonus -= bonus_balance
      else
        amount_due = 0
        remaining_bonus -= amount.round(half: :up)
      end
    end

    # Add bonuses
    if amount >= MIN_AMOUNT_TO_ADD_BONUSES
      remaining_bonus += (amount_due * BONUS_PERCENTAGE).to_i
    end

    self.update(bonuses: remaining_bonus)

    return {
      amount_due: amount_due,
      remaining_bonus: remaining_bonus
    }
  end
end
