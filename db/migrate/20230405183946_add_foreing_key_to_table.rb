class AddForeingKeyToTable < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :employees, :users, column: :user_id, index: true
    add_foreign_key :employees, :addresses, column: :address_id, index: true
    add_foreign_key :restaurants, :users, column: :user_id, index: true
    add_foreign_key :restaurants, :addresses, column: :address_id, index: true
    add_foreign_key :customers, :users, column: :user_id, index: true
    add_foreign_key :customers, :addresses, column: :address_id, index: true
    add_foreign_key :products, :restaurants, column: :restaurant_id, index: true
    add_foreign_key :orders, :restaurants, column: :restaurant_id, index: true
    add_foreign_key :orders, :customers, column: :customer_id, index: true
    add_foreign_key :orders, :order_statuses, column: :order_status_id, index: true
    add_foreign_key :product_orders, :products, column: :product_id, index: true
    add_foreign_key :product_orders, :orders, column: :order_id, index: true
  end
end
