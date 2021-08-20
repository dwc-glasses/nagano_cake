class Public::AddressesController < Public::Base
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "宛先の登録が完了しました"
      redirect_to public_addresses_path
    else
      @addresses = current_customer.addresses
      render :index
    end

  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "宛先を更新しました"
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  def destroy
     Address.find(params[:id]).destroy
     flash[:notice] = "宛先を削除しました"
     redirect_to public_addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
