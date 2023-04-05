class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.integer :user_id, null: false
      t.integer :address_id, null: false
      t.string :phone, null: false
      t.string :email
      t.string :name, null: false
      t.integer :price_range, null: false, default: 1
      t.boolean :active, null: false, default: true
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end
