class CartProduct < ApplicationRecord
  
  def subtotal
    price = Product.find(self.product_id).tax_price
    quantity = self.quantity
    
    return (price*quantity).to_i
  end
  
end
