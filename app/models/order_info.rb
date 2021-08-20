class OrderInfo < ApplicationRecord
  validates :customer_id, :postage, :total_payment, :payment_method, :order_status, :postal_code, :address, :name, presence: true

  def tax_price
    self*1.1
  end

  belongs_to :customer
  has_many :order_products
end
