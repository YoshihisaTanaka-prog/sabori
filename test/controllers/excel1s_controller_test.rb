require 'test_helper'

class Excel1sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @excel1 = excel1s(:one)
  end

  test "should get index" do
    get excel1s_url
    assert_response :success
  end

  test "should get new" do
    get new_excel1_url
    assert_response :success
  end

  test "should create excel1" do
    assert_difference('Excel1.count') do
      post excel1s_url, params: { excel1: { body: @excel1.body, title: @excel1.title } }
    end

    assert_redirected_to excel1_url(Excel1.last)
  end

  test "should show excel1" do
    get excel1_url(@excel1)
    assert_response :success
  end

  test "should get edit" do
    get edit_excel1_url(@excel1)
    assert_response :success
  end

  test "should update excel1" do
    patch excel1_url(@excel1), params: { excel1: { body: @excel1.body, title: @excel1.title } }
    assert_redirected_to excel1_url(@excel1)
  end

  test "should destroy excel1" do
    assert_difference('Excel1.count', -1) do
      delete excel1_url(@excel1)
    end

    assert_redirected_to excel1s_url
  end
end
