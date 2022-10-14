class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :email, null: false, index: { unique: true }
      t.boolean :negative_balance, null: false, default: false
    end
  end
end
