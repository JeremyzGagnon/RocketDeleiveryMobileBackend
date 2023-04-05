class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses do |t|
      t.string :name, null: false
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
