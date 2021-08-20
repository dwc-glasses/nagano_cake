class Product < ApplicationRecord
  attachment :image
  validates :name, :introduction, :genre_id, :price, :image_id, presence: true

  TAX_RATE = 1.1

  def tax_price
    (self.price*TAX_RATE).floor
  end

  def status
    self.sales_status == true ? "販売中" : "販売停止中"
  end

end
