class Product < ApplicationRecord
  attachment :image

  validates :name, :introduction, :genre_id, :price, :image, presence: true
  has_many :cart_products, dependent: :destroy
  belongs_to :genre
  has_many :order_products, dependent: :destroy
  has_many :comments, dependent: :destroy

  TAX_RATE = 1.1

  def tax_price
    (self.price*TAX_RATE).floor
  end

  def status
    self.sales_status == true ? "販売中" : "販売停止中"
  end

end
