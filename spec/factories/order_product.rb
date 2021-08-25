FactoryBot.define do
  factory :order_product do
    price {1200}
    quantity {1}
    product_status {0}
    # association :order_info,
    #   factory: :order_info
    # association :product,
    #   factory: :product
  end
end