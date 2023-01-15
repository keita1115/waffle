class OrderDetail < ApplicationRecord
  belongs_to :order, dependent: :destroy
  belongs_to :item

  enum making_status: { impossible_making: 0, waiting_for_making: 1, making: 2, complete: 3 }

  def with_tax_price
      (price * 1.1).floor
  end

end
