class Order < ApplicationRecord
  has_many :order_details
  has_many :customer_orders, dependent: :destroy
  belongs_to :customer

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
  enum order_status: { "wait_payment": 0, "confirm_payment": 1, "making": 2, "preparing_ship": 3, "finish_prepare": 4}

  def with_tax_price
      (price * 1.1).floor
  end

end
