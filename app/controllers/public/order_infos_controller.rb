class Public::OrderInfosController < Public::Base
  before_action :move_to_signed_in

  def new

  end

  def index
    @order_infos = OrderInfo.where(customer_id: current_customer.id)
  end

  def show
    @order_info = OrderInfo.find(params[:id])
    @postage = 800
  end

  def create

    @order_info = current_customer.order_infos.new(order_info_params)
    if @order_info.save!
      cart_products = current_customer.cart_products
      cart_product_array = Array.new
      cart_products.each do |cart_product|
        product = cart_product.product
        cart_product_array << product.id
        cart_product_array << product.price*1.1
        cart_product_array << cart_product.quantity
        OrderProduct.create(order_id: @order_info.id, product_id: cart_product_array[0], price: cart_product_array[1], quantity: cart_product_array[2], product_status: 0)
        cart_product_array = Array.new
      end
      current_customer.cart_products.destroy_all
      redirect_to action: :complete
    else
      flash[:alert] = "エラーです"
      redirect_to public_cart_products
    end
  end

  def confirm
    #支払い方法、宛先が未選択だった場合はエラー
    if params[:payment_method].nil? || params[:order_address].nil?
      flash[:alert] = "入力を確認してください"
      render :new
    end

    order_address = params[:order_address]
    @payment_method = params[:payment_method]

    if order_address == "selected_address"
      @address = Address.find(params[:select_address].to_i).address
      @postal_code = Address.find(params[:select_address].to_i).postal_code
      @name = Address.find(params[:select_address].to_i).name
    elsif order_address == "my_address"
      @address = current_customer.address
      @postal_code = current_customer.postal_code
      @name = current_customer.family_name + current_customer.given_name
    elsif order_address == "new_address"
      @address = params[:address]
      @postal_code = params[:postal_code]
      @name = params[:name]
      test_empty_array = [@address, @postal_code, @name]

      if test_empty_array.any? {|v| v.empty? }
        flash[:notice] = "入力した配送先を確認してください"
        render :new
      end
      Address.create(address: @address, postal_code: @postal_code, name: @name, customer_id: current_customer.id)
    end

    @cart_products = current_customer.cart_products
    @postage = 800
  end

  def complete
  end

  private
  def order_info_params
    params.require(:order_info).permit(:postage, :total_payment, :payment_method, :order_status, :postal_code, :address, :name)
  end

  def move_to_signed_in
    unless customer_signed_in?
      redirect_to  '/customers/sign_in'
    end
  end
end