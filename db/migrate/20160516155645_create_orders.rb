class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date
      t.string :product
      t.integer :customer_id
      t.integer :price

      t.timestamps null: false
    end
  end
end
