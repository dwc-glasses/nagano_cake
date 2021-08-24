require 'rails_helper'
include FeaturesSpecHelper

feature "マスタ登録" do
  before do
    admin = create(:admin)
    login_as_admin(admin)
  end

  feature "管理者トップ画面" do
    scenario "ヘッダからジャンル一覧へ遷移" do
      click_link "GENRE"
      expect(current_path).to eq admin_genres_path
    end
  end

  feature "ジャンル一覧画面" do
    scenario "新規ジャンルの生成" do
      visit admin_genres_path

      within("form") do
        fill_in "genre[name]", with: "テスト"
        click_button "新規登録"
      end

      new_genre = Genre.order(:id).last
      expect(new_genre.name).to eq("テスト")

      expect(current_path).to eq admin_genres_path
      expect(page).to have_content 'テスト'
    end

    scenario "ヘッダーから商品一覧へ遷移する" do
      visit admin_genres_path

      click_link "PRODUCTS"

      expect(current_path).to eq admin_products_path
    end
  end

  feature "商品一覧画面" do
    scenario "商品新規登録画面へ遷移する" do
      visit admin_products_path

      find('.new_product').click

      expect(current_path).to eq new_admin_product_path
    end
  end

  feature "商品新規登録画面" do
    scenario "商品を登録する" do
      create(:genre) #事前登録
      
      upload_product("テスト商品", "テスト説明文", 1000) #登録画面に遷移して登録を行う
      new_product = Product.order(:id).last
      
      expect(new_product.name).to eq("テスト商品")
      expect(new_product.introduction).to eq("テスト説明文")
      expect(Genre.find(new_product.genre_id).name).to eq("ヨーグルト") #FactoryBot内で指定
      expect(new_product.price).to eq(1000)
      expect(new_product.sales_status).to be_truthy

      expect(current_path).to eq admin_product_path(new_product.id)
    end
  end
  
  feature "商品詳細画面" do
    
    before do
      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000) #登録画面に遷移して登録を行う
    end
    
    scenario "ヘッダから商品一覧画面へ遷移する" do
      click_link "PRODUCTS"
      expect(current_path).to eq admin_products_path
    end
    
    scenario "登録した商品が表示されている" do
      visit admin_products_path
      new_product = Product.order(:id).last
      
      expect(page).to have_content new_product.name
    end
    
  end
  
  feature "商品一覧画面" do
    before do
      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000) #登録画面に遷移して登録を行う
      click_link "PRODUCTS"
    end
    
    scenario "商品新規登録画面が表示される（2回目）" do
      find('.new_product').click
      
      expect(current_path).to eq new_admin_product_path
    end
    
  end
  
  feature "商品一覧画面" do
    before do
      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000) #登録画面に遷移して登録を行う
      click_link "PRODUCTS"
    end
    
    scenario "商品を登録する（2回目）" do
      visit new_admin_product_path
      upload_product("テスト商品2", "テスト説明文2", 500)
      
      new_product = Product.order(:id).last
      
      expect(new_product.name).to eq("テスト商品2")
      expect(new_product.introduction).to eq("テスト説明文2")
      expect(Genre.find(new_product.genre_id).name).to eq("ヨーグルト") #FactoryBot内で指定
      expect(new_product.price).to eq(500)
      expect(new_product.sales_status).to be_truthy
      
      expect(current_path).to eq admin_product_path(new_product.id)
    end
    
  end
  
  feature "商品詳細画面(2回目)" do
    
    before do
      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000)
      upload_product("テスト商品2", "テスト説明文2", 1000)#登録画面に遷移して登録を行う
    end
    
    scenario "ヘッダから商品一覧画面へ遷移する" do
      click_link "PRODUCTS"
      expect(current_path).to eq admin_products_path
    end
    
  end
  
  feature "商品一覧画面(2回目)" do
    
    before do
      create(:genre) #事前登録
      upload_product("テスト商品", "テスト説明文", 1000)
      upload_product("テスト商品2", "テスト説明文2", 1000)#登録画面に遷移して登録を行う
    end
    
    scenario "登録した商品が表示されている" do
      visit admin_products_path
      
      expect(page).to have_content "テスト商品2"
    end
    
    scenario "ヘッダからログアウトしてログイン画面に遷移する" do
      click_link "LOGOUT"
      
      expect(current_path).to eq new_admin_session_path
    end
    
  end



end