class OrderInfo < ApplicationRecord
  validates :customer_id, :postage, :total_payment, :payment_method,
            :order_status, :postal_code, :address, :name,
            presence: true

  def full_name(family_name, given_name)
    "#{family_name} #{given_name}"
  end

  def self.destination(postal_code, address, name)
    "〒#{postal_code} #{address} #{name}"
  end

  belongs_to :customer
  has_many :order_products, foreign_key: "order_id"
end
