require 'test_helper'

class RipplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ripple = ripples(:good_url)
  end

  test "should get index" do
    get root_path
    assert_response :success
    assert_select 'table tbody tr', 10
    assert_select 'nav a', minimum: 3
    assert_select 'h1', 'CONSCIOUS/mess'
  end

  test "should get new" do
    get new_ripple_url
    assert_response :success
  end

  test "should create ripple" do
    assert_difference('Ripple.count') do
      post ripples_url, params: { ripple: { message: @ripple.message, name: @ripple.name, url: @ripple.url } }
    end

    assert_redirected_to root_path
  end

  test "should show ripple" do
    get ripple_url(@ripple)
    assert_response :success
    assert_select 'blockquote', minimum: 1
  end

  test "should get get next 10 ripples, then go back to newest" do
    get root_path
    assert_response :success
    assert_equal session[:page], 1
    get ripples_page_path(7)
    assert_equal session[:page], 7
    assert_equal session[:total_pages], 11
  end
end
