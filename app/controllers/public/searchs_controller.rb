class Public::SearchsController < Public::Base
  def search
    @value = params[:value]
    @how = params[:how]
    @datas = search_for(@value, @how)
    @searched_value = unless @value.to_i == 0
      Genre.find(@value.to_i).name
    else
      @value
    end
  end

  private
  def match(value)
    Product.where(genre_id: value).or(Product.where(name: value))
  end

  def forward(value)
    Product.where("name LIKE ?", "#{value}%")
  end

  def backward(value)
    Product.where("name LIKE ?", "%#{value}")
  end

  def partical(value)
    Product.where("name LIKE ?", "%#{value}%")
  end

  def search_for(value, how)
    case how
    when 'match'
      match(value)
    when 'forward'
      forwad(value)
    when 'backward'
      backward(value)
    when 'partical'
      partical(value)
    end
  end

end
