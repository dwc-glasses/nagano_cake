class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order_info, foreign_key: "order_id"

  validates :price, :quantity, presence: true
end
