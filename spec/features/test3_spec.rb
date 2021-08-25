require 'rails_helper'
include FeaturesSpecHelper

feature "登録情報変更~退会[customer]" do
  before do
    #adminとして商品追加
    admin = create(:admin)
    login_as_admin(admin)

    create(:genre) #事前登録
    upload_product("テスト商品", "テスト説明文", 1000)

    page.driver.submit :delete, "/admin/sign_out", {}

    @customer = create(:customer)
    login_as_customer(@customer)

    #届け先住所追加
    visit public_addresses_path

      within("form") do
        fill_in "address[postal_code]", with: "9876543"
        fill_in "address[address]", with: "沖縄県那覇市泉崎１丁目２−２"
        fill_in "address[name]", with: "佐藤花子"
        click_button "新規登録"
      end

    #カートに商品を入れる
    click_link "NAGANO CAKE"
    find('div.product a').click

    within("form") do
      select "5", from: "cart_product[quantity]"
      click_button "カートに入れる"
    end

    visit public_customers_path

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

    scenario "配送先新規登録後自画面が再描写される" do
      visit public_addresses_path

      within("form") do
        fill_in "address[postal_code]", with: "5678912"
        fill_in "address[address]", with: "札幌市中央区北3条西6丁目"
        fill_in "address[name]", with: "高橋梅子"
        click_button "新規登録"
      end
      expect(current_path).to eq public_addresses_path
    end

    scenario "登録した内容が表示される" do
      visit public_addresses_path

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

    scenario "商品をカートに入れる" do
      click_link "NAGANO CAKE"
      find('div.product a').click

      within("form") do
        select "5", from: "cart_product[quantity]"
        click_button "カートに入れる"
      end
      expect(current_path).to eq public_cart_products_path
    end

    scenario "正しいカートの内容が表示される" do
      visit public_cart_products_path

      new_product = Product.order(:id).last
      new_cart_product = CartProduct.order(:id).last

      expect(new_cart_product.quantity).to eq(5)
      expect(new_cart_product.product_id).to eq(new_product.id)

      expect(page).to have_content 'テスト商品'
    end
  end

  feature "カート画面" do
    scenario "情報入力画面に遷移する" do
      visit public_cart_products_path
      click_link "情報入力に進む"

      expect(current_path).to eq new_public_order_info_path
    end
  end

  feature "注文情報入力画面" do
    before do
      visit new_public_order_info_path
    end

    scenario "登録住所の確認" do
      expect(page).to have_content '沖縄県那覇市泉崎１丁目２−２'
      expect(page).to have_content '佐藤花子'
    end

    scenario "注文情報を入力後、サンクスページに遷移する" do
      choose "credit-card"
      choose "selected_address"

      click_button "確認画面へ進む"
      click_link "注文を確定する"

      expect(current_path).to eq public_order_infos_complete_path
    end
  end

  feature "サンクスページ" do
    before do
      visit new_public_order_info_path
      choose "credit-card"
      choose "selected_address"

      click_button "確認画面へ進む"
      click_link "注文を確定する"
    end

    scenario "トップ画面へ遷移する" do
      click_link "NAGANO CAKE"
      expect(current_path).to eq public_root_path
    end
  end

  feature "トップ画面" do
    scenario "マイページへ遷移する" do
      click_link "MyPage"
      expect(current_path).to eq public_customers_path
    end
  end

  feature "トップ画面" do
    scenario "マイページへ遷移する" do
      click_link "MyPage"
      expect(current_path).to eq public_customers_path
    end
  end

  feature "マイページ" do
    before do
      click_link "MyPage"
    end
    scenario "配送先一覧へ遷移する" do
      click_link "address-list"
      expect(current_path).to eq public_addresses_path
    end
  end

  feature "配送先一覧画面" do
    before do
      click_link "MyPage"
    end
    scenario "配送先一覧へ遷移する" do
      click_link "address-list"

      expect(page).to have_content '佐藤花子'
    end
  end

  feature "マイページ" do
    before do
      click_link "MyPage"
    end
    scenario "会員情報変更ページに遷移する" do
      click_link "編集する"
      expect(current_path).to eq public_customers_edit_path
    end
  end

  feature "会員情報編集" do
    before do
      click_link "MyPage"
      click_link "編集する"
      click_link "退会する"
    end
    scenario "退会ボタンを押すとアラートが表示される" do
      expect(current_path).to eq public_customers_suspend_path
    end
    scenario "" do
      click_link "退会する"
      expect(current_path).to eq public_root_path
    end
  end

  feature "会員情報編集" do
    before do
      click_link "MyPage"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
    end
    scenario "退会後ヘッダーが未ログイン状態になっている" do
      expect(page).to have_content 'LOGIN'
    end

    scenario "退会済みのままログイン画面に遷移する" do
      click_link 'LOGIN'
      expect(current_path).to eq new_customer_session_path
    end
  end

  feature "ログイン画面" do
    before do
      click_link "MyPage"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
    end

    scenario "退会アカウントでログインするとログイン不可" do
      login_as_customer(@customer)
      expect(page).to have_content '退会済みのためログインできません'
    end
  end

end

feature "登録情報変更~退会[admin]" do
  before do
    customer = create(:customer)
    login_as_customer(customer)
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
      
    click_link "MyPage"
    click_link "編集する"
    click_link "退会する"
    click_link "退会する"

    admin = create(:admin)
    login_as_admin(admin)
  end

  feature "ログイン画面" do
    scenario "顧客注文一覧画面に遷移する" do
      expect(current_path).to eq admin_order_infos_path
    end
  end

  feature "管理者トップ画面" do
    scenario "会員一覧画面へ遷移する" do
      click_link "CUSTOMERS"
      expect(current_path).to eq admin_customers_path
    end
  end

  feature "会員一覧画面" do
    scenario "退会ユーザーの確認" do
      click_link "CUSTOMERS"

      sus_customer = Customer.order(:id).last
      expect(sus_customer.suspended).to eq(true)

      expect(page).to have_content '退会'
    end

    scenario "退会ユーザーの会員情報詳細画面へ遷移する" do
      click_link "CUSTOMERS"
      sus_customer = Customer.order(:id).last
      click_link "#{sus_customer.family_name + sus_customer.given_name}"
      
      expect(current_path).to eq admin_customer_path(sus_customer.id)
    end
  end
  
  feature "会員一覧画面" do
    before do
      click_link "CUSTOMERS"
      sus_customer = Customer.order(:id).last
      click_link "#{sus_customer.family_name + sus_customer.given_name}"
    end
    
    scenario "退会ユーザー情報の確認" do
      expect(page).to have_content '田中二郎'
      expect(page).to have_content "長野県長野市大字南長野幅下６９２−２"
    end
    
    scenario "管理者ログイン画面" do
      click_link "LOGOUT"
      expect(current_path).to eq new_admin_session_path
    end
  end

end