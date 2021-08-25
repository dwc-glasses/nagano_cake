require 'rails_helper'
include FeaturesSpecHelper

feature "注文ステータスの変更" do
  before do
    admin = create(:admin)
    login_as_admin(admin)

    @genre = create(:genre)
    upload_product("テスト商品", "テスト説明文", 1000)
    @product = Product.order(:id).last
    @customer = create(:customer)
    @order_info = create(:order_info, customer_id:@customer.id)
    @order_product = create(:order_product, order_id: @order_info.id, product_id: @product.id)
  end

  context "管理者側での操作" do
    feature "注文詳細画面" do
      scenario "ヘッダから注文一覧画面へ遷移" do
        click_link "ORDER"
        expect(current_path).to eq admin_order_infos_path
      end

      scenario "注文詳細画面へ遷移" do
        visit admin_order_infos_path
        click_link "#{@order_info.created_at.strftime("%Y/%m/%d %H:%M")}"
        expect(current_path).to eq admin_order_info_path(@order_info)
      end

      scenario "注文ステータスを入金確認にする" do
        visit admin_order_info_path(@order_info)
        select '入金確認', from: 'order_info[order_status]'
        click_on '注文の更新'
        new_order_info = OrderInfo.order(:id).last
        expect(new_order_info.order_status).to eq 1
      end

      scenario "製作ステータスを1つ製作中にする" do
        visit admin_order_info_path(@order_info)
        select '製作中', from: 'order_product[product_status]'
        click_on '製品の更新'
        new_order_product = OrderProduct.order(:id).last
        expect(new_order_product.product_status).to eq 2
      end

      scenario "製作ステータスを全て製作完了にする"do
        visit admin_order_info_path(@order_info)
        #order_productそれぞれに対して処理する
        select '制作完了', from: 'order_product[product_status]'
        click_on '製品の更新'
        new_order_product = OrderProduct.order(:id).last
        expect(new_order_product.product_status).to eq 3
      end

      scenario "注文ステータスを発注済みにする" do
        visit admin_order_info_path(@order_info)
        select '発送済み', from: 'order_info[order_status]'
        click_on '注文の更新'
        new_order_info = OrderInfo.order(:id).last
        expect(new_order_info.order_status).to eq 4
      end

      scenario "ヘッダからログアウトボタンを押下する" do
        click_on "LOGOUT"
        expect(current_path).to eq new_admin_session_path
      end
    end
  end


  context "顧客側での操作" do
    before do
      login_as_customer(@customer)
    end

    scenario "ヘッダからマイページに遷移する" do
      click_on "MyPage"
      expect(current_path).to eq public_customers_path
    end

    scenario "注文履歴一覧を表示する" do
      click_on "注文一覧を見る"
      expect(current_path).to eq public_order_infos_path

    end

    scenario "注文詳細を表示する" do
      click_on "注文一覧を見る"
      click_on "表示する"
      expect(current_path).to eq public_order_info_path(@order_info)
    end

    scenario "注文ステータスが発送済みになっている" do
      # @order_info.update(order_status: 4)
      click_on "注文一覧を見る"
      click_on "表示する"
      expect(page).to have_content "発送済み"
    end
  end
end