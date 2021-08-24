module FeaturesSpecHelper
  def login_as_admin(admin, password="foobar")
    visit new_admin_session_path
    within("#new_admin") do
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
    end
  end
  
  def login_as_customer(customer, password="password")
    visit new_customer_session_path
    within("#new_customer") do
      fill_in "customer[email]", with: customer.email
      fill_in "customer[password]", with: customer.password
      click_button "ログイン"
    end
  end
  
  def upload_product(name, introduction, price)
    visit new_admin_product_path
    within("form") do
      attach_file 'product[image]', 'app/assets/images/rspec_test/test.jpeg'
      fill_in "product[name]", with: name
      fill_in "product[introduction]", with: introduction
      find("option[value='1']").select_option
      fill_in "product[price]", with: price
      find('.salse_true').click
      click_button "新規登録"
    end
  end
  
end