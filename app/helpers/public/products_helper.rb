module Public::ProductsHelper
  def product_form_hash
    hash = {  :image => {:label => "商品画像", :form => :attachment },
              :name => {:label => "商品名", :form => :field, :placeholder => "商品名" },
              :introduction => {:label => "商品説明", :form => :area, :placeholder => "ここに説明文を記述します" },
              :genre_id => {:label => "ジャンル", :form => :genre },
              :price => {:label => "税抜き価格", :form => :field, :placeholder => "1000", :option => "円" } }
    return hash
  end
end
