require 'test_helper'

class Public::OrderInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_order_infos_new_url
    assert_response :success
  end

  test "should get index" do
    get public_order_infos_index_url
    assert_response :success
  end

  test "should get show" do
    get public_order_infos_show_url
    assert_response :success
  end

  test "should get create" do
    get public_order_infos_create_url
    assert_response :success
  end

  test "should get confirm" do
    get public_order_infos_confirm_url
    assert_response :success
  end

  test "should get complete" do
    get public_order_infos_complete_url
    assert_response :success
  end

end
