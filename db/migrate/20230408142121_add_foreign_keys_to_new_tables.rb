class AddForeignKeysToNewTables < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :couriers, :users, column: :user_id, index: true
    add_foreign_key :couriers, :addresses, column: :address_id, index: true
    add_foreign_key :couriers, :courier_statuses, column: :courier_status_id, index: true
  end
end
