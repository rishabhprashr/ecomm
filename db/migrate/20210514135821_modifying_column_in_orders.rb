class ModifyingColumnInOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :invoice_no
    add_column :orders, :invoice_no, :string
  end
end
