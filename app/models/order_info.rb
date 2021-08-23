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

  def self.status_search(sortword)
    case sortword
    when 0
      where(order_status: 0)
    when 1
      where(order_status: 1)
    when 2
      where(order_status: 2)
    when 3
      where(order_status: 3)
    when 4
      where(order_status: 4)
    end
  end

  belongs_to :customer
  has_many :order_products, foreign_key: "order_id"
end
