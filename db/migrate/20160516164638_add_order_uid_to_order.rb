class AddOrderUidToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :order_uid, :integer
  end
end
