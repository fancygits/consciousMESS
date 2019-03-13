require 'test_helper'

class RipplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ripple = ripples(:good_url)
  end

  test "should get index" do
    get ripples_url
    assert_response :success
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
  end

end
