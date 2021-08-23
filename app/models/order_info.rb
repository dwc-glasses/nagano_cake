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

  scope :scope_six_days_ago, -> {where(created_at: Time.current.ago(6.days).all_day)}
  scope :scope_five_days_ago, -> {where(created_at: Time.current.ago(5.days).all_day)}
  scope :scope_four_days_ago, -> {where(created_at: Time.current.ago(4.days).all_day)}
  scope :scope_three_days_ago, -> {where(created_at: Time.current.ago(3.days).all_day)}
  scope :scope_two_days_ago, -> {where(created_at: Time.current.ago(2.days).all_day)}
  scope :scope_a_day_ago, -> {where(created_at: Time.current.ago(1.days).all_day)}
  scope :scope_today, -> {where(created_at: Time.current.beginning_of_day..Time.current)}

end
