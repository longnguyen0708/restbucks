class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :location, null: false
      t.string :name, null: false
      t.integer :quantity, null: false
      t.string :milk, null: false
      t.string :size, null: false
      t.string :shots, null: false
      t.string :status, null: false
      t.float :cost, null: false
      t.datetime :paid_time
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
