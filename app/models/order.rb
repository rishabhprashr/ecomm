class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  before_create :assign_invoice

  def assign_invoice
    self.invoice_no = random_string
  end

  def random_string
    (0...8).map { (65 + rand(26)).chr }.join + Time.now.to_f.to_s.gsub('.', '')
  end

  def format
    result = {
      id: id,
      invoice_no: invoice_no,
      created_at: created_at
    }
    totalPrice=0
    data=[]
    self.order_items.each do |order_item|
      data << order_item.format
      totalPrice+=order_item.quantity*order_item.product_price
    end

    result[:items] = data
    result[:totalPrice] = totalPrice
    return result
  end
end