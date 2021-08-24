require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "ログイン" do
    example "メールアドレスは入力必須" do
      customer = build(:customer, email:"")
      expect(customer).not_to be_valid
    end
    
    example "passwordは6桁以上" do
      customer1 = build(:customer, password:"passw")
      customer2 = build(:customer, password:"passwa")
      expect(customer1).not_to be_valid
      expect(customer2).to be_valid
    end
  end
  
  describe "ログイン後" do
    
    example ""do
      customer = create(:customer)
      sign_in customer
      get public_customers_path(customer.id)
      expect(response).to have_http_status(200)
    end
    
  end
end