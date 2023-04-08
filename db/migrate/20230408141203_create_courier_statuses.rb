class CreateCourierStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :courier_statuses do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
      add_index :courier_statuses, :name, unique: true

      CourierStatus.create(name: 'free')
      CourierStatus.create(name: 'busy')
      CourierStatus.create(name: 'full')
      CourierStatus.create(name: 'offline')
    
  end
end
