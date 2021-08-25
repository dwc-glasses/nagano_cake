require 'rails_helper'
include FeaturesSpecHelper

feature "登録〜注文" do
  before do
    admin = create(:admin)
    login_as_admin(admin)
    create(:genre)
    upload_product("テスト商品", "テスト説明文", 1000)
    click_link 'LOGOUT'
  end
  feature "新規登録画面へ遷移" do
    scenario "新規登録画面へのリンクを押下する" do
      visit public_root_path
      click_on 'SIGN UP'
      expect(current_path).to eq new_customer_registration_path
    end
  end

  feature "新規登録" do
    scenario '新規登録する' do
    visit new_customer_registration_path
    within('.new_customer') do
      fill_in 'customer_family_name', with: '苗字漢字'
      fill_in 'customer_given_name', with: '名前漢字'
      fill_in 'customer_family_name_kana', with: '苗字カナ'
      fill_in 'customer_given_name_kana', with: '名前カナ'
      fill_in 'customer_email', with: 'test@test'
      fill_in 'customer_postal_code', with: '1111111'
      fill_in 'customer_address', with: 'テスト住所'
      fill_in 'customer_phone', with: '11111111111'
      fill_in 'customer_password', with: '111111'
      fill_in 'customer_password_confirmation', with: '111111'
      click_button '新規登録'
      end

    #入力した情報が登録されているか
    new_customer = Customer.order(:id).last
    expect(new_customer.family_name).to eq '苗字漢字'
    expect(new_customer.given_name).to eq '名前漢字'
    expect(new_customer.family_name_kana).to eq '苗字カナ'
    expect(new_customer.given_name_kana).to eq '名前カナ'
    expect(new_customer.email).to eq 'test@test'
    expect(new_customer.postal_code).to eq '1111111'
    expect(new_customer.address).to eq 'テスト住所'
    expect(new_customer.phone).to eq '11111111111'

    #現在マイページにいるか
    expect(current_path).to eq public_customers_path
    #新規登録時に入力した情報が表示されているか
    expect(page).to have_content '苗字漢字'
    expect(page).to have_content '名前漢字'
    expect(page).to have_content '苗字カナ'
    expect(page).to have_content '名前カナ'
    expect(page).to have_content 'test@test'
    expect(page).to have_content '1111111'
    expect(page).to have_content 'テスト住所'
    expect(page).to have_content '11111111111'

    #ヘッダーがログイン後の表示になっているか
    expect(page).to have_content 'LOGOUT'
    expect(page).to have_content 'CART'
    expect(page).to have_content 'MyPage'
    end

  end
end

feature 'ログイン状態から開始のfeature' do
  before do
    admin = create(:admin)
    login_as_admin(admin)
    create(:genre)
    upload_product("テスト商品", "テスト説明文", 1000)
    @product = Product.order(:id).last
    @product_id = @product.id
    if @product.sales_status
      @sales_status = "販売中"
    else
      @sales_status = "売り切れ"
    end

    click_link 'LOGOUT'
    customer = create(:customer)
    password = "password"
    login_as_customer(customer, password)
  end

  feature 'マイページ' do
    scenario 'ヘッダーのロゴ画像を押下する' do
      visit public_customers_path
      click_link 'NAGANO CAKE'
      expect(current_path).to eq public_root_path
    end
  end

  feature 'トップ画面(1回目)' do

    scenario '任意の商品画像を押下する' do
      visit public_root_path
      #該当商品の詳細ページへ遷移しているか
      click_link "image#{@product.id}"
      expect(current_path).to eq "/products/#{@product.id}"

      #商品情報が正しく表示されているか
      expect(page).to have_content @product.name
      expect(page).to have_content @product.introduction
      expect(page).to have_content @product.genre.name
      expect(page).to have_content (@product.price*1.1).floor
      expect(page).to have_content @sales_status
    end
  end

  feature '商品詳細画面(1回目)' do

    scenario '個数を選択し、カートに入れるボタンを押す' do
      visit "/products/#{@product.id}"
      # within('form') do
        select '3', from: 'cart_product[quantity]'
      # end
      click_button 'カートに入れる'
      #カート内商品一覧画面へ遷移しているか
      expect(current_path).to eq public_cart_products_path

      #カートの中身が正しく表示されているか
      expect(page).to have_content @product.name
      expect(page).to have_content (@product.price*1.1).floor
      expect(page).to have_select('cart_product[quantity]', selected: '3' )
      expect(page).to have_content 3*(@product.price*1.1).floor
    end
  end

  feature 'カート画面(1回目)' do
    scenario '買い物を続けるボタンを押下する' do
      visit public_cart_products_path
      #トップ画面ん遷移するか
      click_on "買い物を続ける"
      expect(current_path).to eq public_root_path
    end
  end

  feature 'トップ画面(2回目)' do
    scenario 'ヘッダの商品一覧へのリンクをクリックする' do
      click_link 'PRODUCTS'

      #商品一覧画面へ遷移する
      expect(current_path).to eq public_products_path
    end
  end

  feature '商品一覧画面' do
    scenario '任意の商品画像を押下する' do
      visit public_products_path
      click_link "image#{@product.id}"
      #該当商品の詳細画面に遷移しているか
      expect(current_path).to eq "/products/#{@product.id}"
      #商品情報が正しく表示されてるか
      expect(page).to have_content @product.name
      expect(page).to have_content @product.introduction
      expect(page).to have_content @product.genre.name
      expect(page).to have_content (@product.price*1.1).floor
      expect(page).to have_content @sales_status
    end
  end

  feature '商品詳細画面(2回目)' do
    scenario '個数を選択し、カートに入れるボタンを押す' do
      visit "/products/#{@product.id}"
      within('.cartin') do
        select '3', from: 'cart_product[quantity]'
      end
      click_button 'カートに入れる'
      #カート内商品一覧画面へ遷移しているか
      expect(current_path).to eq public_cart_products_path

      #カートの中身が正しく表示されているか
      expect(page).to have_content @product.name
      expect(page).to have_content (@product.price*1.1).floor
      expect(page).to have_select('cart_product[quantity]', selected: '3' )
      expect(page).to have_content 3*(@product.price*1.1).floor
    end
  end

  feature 'カート画面(2回目)' do
    before do
       upload_cart_product(@product)
    end
    scenario '商品の個数を変更し、更新ボタンを押下する' do
      visit public_cart_products_path
      within('.cartin') do
        select '6', from: 'cart_product[quantity]'
      end
      click_button '変更'
      expect(current_path).to eq public_cart_products_path
      expect(page).to have_select(selected: '6')
    end

    scenario '情報入力に進むボタンを押下する' do
      visit public_cart_products_path
      click_link '情報入力に進む'
      expect(current_path).to eq new_public_order_info_path
    end
  end

  feature '注文情報入力画面' do
     before do
      upload_cart_product(@product)
    end
    scenario '確認画面へ進むボタンを押下する' do
      visit new_public_order_info_path
      within('.orderinfo') do
      choose 'creditcard'
      choose 'new-address'
      fill_in 'postal_code', with: '2222222'
      fill_in 'address', with: '地球のどこか'
      fill_in 'name', with: 'テス子'
      click_button '確認画面へ進む'
      end
      expect(current_path).to eq public_order_infos_confirm_path
    end
  end
  
    feature 'カートに商品があることが前提のテスト' do
      before do
        upload_cart_product(@product)
        visit new_public_order_info_path
        within('.orderinfo') do
          choose 'creditcard'
          choose 'new-address'
          fill_in 'postal_code', with: '2222222'
          fill_in 'address', with: '地球のどこか'
          fill_in 'name', with: 'テス子'
          click_button '確認画面へ進む'
        end
      end
    
    feature '注文確認画面' do
      scenario '注文確定ボタンを押下する' do
        click_link '注文を確定する'
        expect(current_path).to eq public_order_infos_complete_path
      end
    end
  
    feature 'サンクスページ' do
      before do
        click_link '注文を確定する'
      end
      
      scenario 'ヘッダーのマイページへのリンクを押下する' do
        click_link 'MyPage'
        expect(current_path).to eq public_customers_path
      end
    end
  
    feature 'マイページ' do
      before do
        click_link '注文を確定する'
        click_link 'MyPage'
      end
      
      scenario '注文履歴一覧へのリンクを押下する' do
        within('.to-order-infos-index') do
          click_link '一覧を見る'
        end
        expect(current_path).to eq  public_order_infos_path
      end
    end
    
    feature '注文済が前提のテスト' do
      before do
        click_link '注文を確定する'
        click_link 'MyPage'
        within('.to-order-infos-index') do
          click_link '一覧を見る'
        end
        @order_info = OrderInfo.order(:id).last
      end
      
      feature '注文履歴一覧画面' do
        scenario '先程の注文詳細画面へのリンクを押下する' do
            click_link '表示する'
          expect(current_path).to eq "/order_infos/#{@order_info.id}"
        end
      end
    
      feature '注文詳細画面' do
        scenario '詳細画面を表示' do
          expect(page).to have_content '入金待ち'
        end
      end
    end
  end
end