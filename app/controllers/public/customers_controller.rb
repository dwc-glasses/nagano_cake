class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end
  
  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    customer = Customer.find(current_customer.id)
    if customer.update(customer_params)
      redirect_to :public_customers_path
    else
      @customer = Customer.find(current_customer.id)
      render :edit
    end
  end
  
  def suspend
  end
  
  def suspended
    customer = Customer.find(current_customer.id)
    customer.update({suspended: true})
    redirect_to :public_root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:family_name, :given_name, :family_name_kana, :given_name_kana, :postal_code, :address, :phone, :email)
  end
end
