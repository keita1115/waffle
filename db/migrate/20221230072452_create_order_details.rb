class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :price
      t.integer :quantity, null: false
      t.integer :making_status, null: false, default: 0
      t.timestamps
    end
  end
end
