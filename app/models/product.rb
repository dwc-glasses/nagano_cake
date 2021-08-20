class Product < ApplicationRecord
  attachment :image
  validates :name, :genre_id, :price, presence: true
  has_many :cart_products, dependent: :destroy
  belongs_to :genre

  has_many :order_products, dependent: :destroy

  TAX_RATE = 1.1

  def tax_price
    (self.price*TAX_RATE).floor
  end

  def status
    self.sales_status == true ? "販売中" : "売り切れ"
  end

end
