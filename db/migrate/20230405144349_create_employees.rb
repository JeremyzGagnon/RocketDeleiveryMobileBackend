class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.integer :user_id, null: false, unique: true
      t.integer :adress_id, null:false
      t.string :phone, null: false
      t.string :email
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
