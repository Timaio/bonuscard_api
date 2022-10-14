class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.text :name, null: false, index: { unique: true }
    end
  end
end
