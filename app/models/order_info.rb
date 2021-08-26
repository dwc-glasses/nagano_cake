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
  has_many :order_products, class_name: "OrderProduct", foreign_key: "order_id", dependent: :destroy

  scope :scope_six_days_ago, ->   {where(created_at: Time.current.ago(6.days).all_day)}
  scope :scope_five_days_ago, ->  {where(created_at: Time.current.ago(5.days).all_day)}
  scope :scope_four_days_ago, ->  {where(created_at: Time.current.ago(4.days).all_day)}
  scope :scope_three_days_ago, -> {where(created_at: Time.current.ago(3.days).all_day)}
  scope :scope_two_days_ago, ->   {where(created_at: Time.current.ago(2.days).all_day)}
  scope :scope_a_day_ago, ->      {where(created_at: Time.current.ago(1.days).all_day)}
  scope :scope_today, ->          {where(created_at: Time.current.beginning_of_day..Time.current)}
end
