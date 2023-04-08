class AddCourierIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :courier_id, :integer
    add_foreign_key :orders, :couriers, column: :courier_id, index: true, null: true
  end
end