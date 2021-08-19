class OrderInfo < ApplicationRecord
  validates :customer_id, :postage, :total_payment, :payment_method, :order_status, :postal_code, :address, :name, presence: true
end
