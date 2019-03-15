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

  # Starts on page 1, confirms redirect and 10 ripples, except page 11 which has 5
  test "should navigate to each page from page 1 up to 11" do
    get root_path
    assert_equal session[:total_pages], 11
    assert_equal session[:page], 1
    1.upto(10) do |page|
      get ripples_page_path(page)
      assert_response :redirect
      assert_equal session[:page], page
      get root_path
      assert_select 'table tbody tr', minimum: 10
    end
    get ripples_page_path(11)
    assert_response :redirect
    assert_equal session[:page], 11
    get root_path
    assert_select 'table tbody tr', minimum: 5
  end

  # Starts on page 11, confirms redirect and 10 ripples, except page 11 which has 5
  test "should navigate to each page from page 11 down to 1" do
    get root_path
    assert_equal session[:total_pages], 11
    assert_equal session[:page], 1
    get ripples_page_path(11)
    assert_response :redirect
    assert_equal session[:page], 11
    get root_path
    assert_select 'table tbody tr', minimum: 5
    10.downto(1) do |page|
      get ripples_page_path(page)
      assert_response :redirect
      assert_equal session[:page], page
      get root_path
      assert_select 'table tbody tr', minimum: 10
    end
  end

  test "should not navigate to pages beyond the total page range" do
    get ripples_page_path(15)
    assert_response :redirect
    assert_equal session[:page], 11 #Max page
    get ripples_page_path(12)
    assert_response :redirect
    assert_equal session[:page], 11 #Max page
    get ripples_page_path(0)
    assert_response :redirect
    assert_equal session[:page], 1  #Min page
    get ripples_page_path(-3)
    assert_response :redirect
    assert_equal session[:page], 1  #Min page
  end

end
