class Product < ApplicationRecord
  TAX_RATE = 1.1
  
  def tax_price
    (self.price*TAX_RATE).floor
  end
  
  def status
    self.sales_status == true ? "販売中" : "売り切れ"
  end
  
end
