class AddPaidTimeToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :paid_time, :datetime
  end
end
