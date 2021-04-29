class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :invoice_no
      t.references :user

      t.timestamps
    end
  end
end
