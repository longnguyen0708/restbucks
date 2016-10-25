class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :card_holder_name
      t.string :card_number
      t.integer :expiry_month
      t.integer :expiry_year
      t.float :amount
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
