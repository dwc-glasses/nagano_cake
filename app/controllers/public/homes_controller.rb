class Public::HomesController < ApplicationController
  def top
    @products = Product.all.reverse_order
  end

  def about
  end
end
