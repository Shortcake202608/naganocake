class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum :making_status, {
    unavailable: 0,
    waiting: 1,
    making: 2,
    finished: 3
  }

  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  def price_with_tax
    (price * 1.1).floor
  end

  def subtotal
    item.price_with_tax * amount
  end

end
