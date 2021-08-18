class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new
  end

  def update
    @address = Address.find(params[:id])
  end

  def destroy
    @address = Address.find(params[:id])
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
