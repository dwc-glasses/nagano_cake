FactoryBot.define do
  factory :order_info do
    postage {800}
    total_payment {2000}
    payment_method {0}
    postal_code {"1111111"}
    address{"東京都千代田区千代田１−１"}
    name{"インフラトップ"}
    created_at{Time.now}
  end
end