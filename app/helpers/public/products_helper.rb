module Public::ProductsHelper
  def product_form_hash
    hash = { :image => ["商品イメージ", :attachment],
                        :name => ["商品名", :field],
                        :introduction => ["商品説明", :area],
                        :genre_id => ["ジャンル", :genre],
                        :price => ["価格（税抜き）", :field]  }
    return hash
  end
  
  def genre_form_array
    array = Array.new
      Genre.all.each do |g|
        array << [g.name, g.id]
      end 
    return array
  end
  
end
