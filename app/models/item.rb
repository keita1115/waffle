class Item < ApplicationRecord
  
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :item_image

  
  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  has_many :order_items

  def get_item_image
    (item_image.attached?) ? item_image : "no_image.jpg"
  end

  def with_tax_price
      (price * 1.1).floor
  end
  
end
