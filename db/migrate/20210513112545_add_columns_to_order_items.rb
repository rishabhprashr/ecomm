class AddColumnsToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :product_name, :string
    add_column :order_items, :product_price, :integer
  end
end
