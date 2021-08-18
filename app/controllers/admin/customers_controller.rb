class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to admin_customers_path
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :family_name, :given_name, :family_name_kana, :given_name_kana, :phone, :address, :postal_code, :suspended)
  end
end
