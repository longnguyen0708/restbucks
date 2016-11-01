class RemovePaidTimeFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :paid_time, :string
  end
end
