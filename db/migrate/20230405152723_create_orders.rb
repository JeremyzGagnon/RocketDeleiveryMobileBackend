class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :restaurant_id, null: false
      t.integer :customer_id, null: false
      t.integer :order_status_id, null: false
      t.integer :restaurant_rating

      t.timestamps null: false
    end
  end
end
