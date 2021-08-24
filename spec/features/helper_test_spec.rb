require 'rails_helper'
include FeaturesSpecHelper

feature "login_as_adminの確認" do
  feature "ログイン画面" do
    scenario "ログイン後、管理者トップ画面が表示される" do
      admin = create(:admin)
      
      visit new_admin_session_path
      within("#new_admin") do
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
      end
      
      expect(page).to have_content 'ログインしました'
      expect(current_path).to eq admin_customers_path
    end
  end
end