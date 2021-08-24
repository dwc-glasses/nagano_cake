require 'rails_helper'
include FeaturesSpecHelper

feature "登録情報変更~退会" do
  before do
    @customer = create(:customer)
    login_as_customer(@customer)
  end

  feature "マイページ" do
    scenario "会員情報編集画面" do
      click_link "編集する"
      expect(current_path).to eq public_customers_edit_path
    end
  end

  feature "会員情報編集画面" do
    before do
      visit public_customers_edit_path

      within("form") do
        fill_in "customer[family_name]", with: "田中"
        fill_in "customer[given_name]", with: "二郎"
        fill_in "customer[family_name_kana]", with: "タナカ"
        fill_in "customer[given_name_kana]", with: "ジロウ"
        fill_in "customer[postal_code]", with: "9999999"
        fill_in "customer[address]", with: "長野県長野市大字南長野幅下６９２−２"
        fill_in "customer[phone]", with: "00012345678"
        fill_in "customer[email]", with: "customer2@example.com"
        click_button "編集内容を保存"
      end
    end

    scenario "情報変更後マイページへログイン" do
      expect(current_path).to eq public_customers_path
    end

    scenario "変更内容が表示される" do
      edited_customer = Customer.order(:id).last

      expect(edited_customer.family_name).to eq("田中")
      expect(edited_customer.given_name).to eq("二郎")
      expect(edited_customer.family_name_kana).to eq("タナカ")
      expect(edited_customer.given_name_kana).to eq("ジロウ")
      expect(edited_customer.postal_code).to eq("9999999")
      expect(edited_customer.address).to eq("長野県長野市大字南長野幅下６９２−２")
      expect(edited_customer.phone).to eq("00012345678")
      expect(edited_customer.email).to eq("customer2@example.com")

      expect(page).to have_content '田中'
      expect(page).to have_content '二郎'

    end
  end

  feature "マイページ" do
    scenario "配送先一覧画面に遷移する" do
      click_link "address-list"
      expect(current_path).to eq public_addresses_path
    end
  end

  feature "配送先一覧画面" do
    before do
      visit public_addresses_path

      within("form") do
        fill_in "address[postal_code]", with: "9876543"
        fill_in "address[address]", with: "沖縄県那覇市泉崎１丁目２−２"
        fill_in "address[name]", with: "佐藤花子"
        click_button "新規登録"
      end

    end

    scenario "配送先新規登録後自画面が再描写される" do
      expect(current_path).to eq public_addresses_path
    end

    scenario "登録した内容が表示される" do
      new_address = Address.order(:id).last
      expect(new_address.postal_code).to eq("9876543")
      expect(new_address.address).to eq("沖縄県那覇市泉崎１丁目２−２")
      expect(new_address.name).to eq("佐藤花子")

      expect(page).to have_content '佐藤花子'
    end

    scenario "ヘッダーロゴクリックでトップ画面に遷移する" do
      click_link "NAGANO CAKE"
      expect(current_path).to eq public_root_path
    end
  end

  feature "トップ画面" do
    before do
      admin = create(:admin)
      login_as_admin(admin)

      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000)

      page.driver.submit :delete, "/admin/sign_out", {}

      click_link "NAGANO CAKE"
      find('div.product a').click
    end

    scenario "商品画像を選択する" do
      new_product = Product.order(:id).last

      expect(current_path).to eq public_product_path(new_product.id)
    end

    scenario "正しい商品情報が表示される" do
      expect(page).to have_content 'テスト商品'
      expect(page).to have_content 'テスト説明文'
      expect(page).to have_content 'ヨーグルト'
    end
  end

  feature "商品詳細画面" do
    before do
      admin = create(:admin)
      login_as_admin(admin)

      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000)

      page.driver.submit :delete, "/admin/sign_out", {}

      login_as_customer(@customer)

      click_link "NAGANO CAKE"
      find('div.product a').click

      within("form") do
        select "5", from: "cart_product[quantity]"
        click_button "カートに入れる"
      end
    end

    scenario "商品をカートに入れる" do
      expect(current_path).to eq public_cart_products_path
    end

    scenario "正しいカートの内容が表示される" do
      new_product = Product.order(:id).last
      new_cart_product = CartProduct.order(:id).last

      expect(new_cart_product.quantity).to eq(5)
      expect(new_cart_product.product_id).to eq(new_product.id)
      
      expect(page).to have_content 'テスト商品'
    end
  end

end