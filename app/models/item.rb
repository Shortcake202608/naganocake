class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  has_one_attached :item_image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
end
