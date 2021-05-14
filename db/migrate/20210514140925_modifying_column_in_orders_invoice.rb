class ModifyingColumnInOrdersInvoice < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :invoice_no,:string, :null => false
  end
end
