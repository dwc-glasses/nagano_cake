class Public::HomesController < Public::Base
  def top
    @products = Product.all.reverse_order
  end

  def about
  end
end
