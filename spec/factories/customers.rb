FactoryBot.define do
  factory :customer do
    email {"customer@example.com"}
    password {"password"}
    family_name {"山田"}
    given_name {"太郎"}
    family_name_kana {"ヤマダ"}
    given_name_kana {"タロウ"}
    phone {"09012345678"}
    postal_code {"1000000"}
    address {"東京都千代田区千代田１−１"}
    suspended {false}
  end
end