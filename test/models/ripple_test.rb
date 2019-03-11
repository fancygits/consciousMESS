require 'test_helper'

class RippleTest < ActiveSupport::TestCase
  fixtures :ripples

  test "ripple name and message must not be empty" do
    ripple = Ripple.new
    assert ripple.invalid?
    assert ripple.errors[:name].any?
    assert ripple.errors[:message].any?
  end
  
  test "urls starting with www are prepended with http://" do
    ripple = Ripple.new(name:     "Test User",
                        url:      "www.example.com",
                        message:  "This is a test message.")
    assert ripple.valid?
    assert_equal "http://www.example.com", ripple.url
  end
  
  test "urls starting with http:// are valid and not prepended" do
    ripple = Ripple.new(name:     "Test User",
                        url:      "http://www.example.com",
                        message:  "This is a test message.")
    assert ripple.valid?
    assert_equal "http://www.example.com", ripple.url
  end
  
  test "urls starting with https:// are valid and not prepended" do
    ripple = Ripple.new(name:     "Test User",
                        url:      "https://www.example.com",
                        message:  "This is a test message.")
    assert ripple.valid?
    assert_equal "https://www.example.com", ripple.url
  end
  
  test "urls starting with http:// but missing www are valid" do
    ripple = Ripple.new(name:     "Test User",
                        url:      "https://example.com",
                        message:  "This is a test message.")
    assert ripple.valid?
    assert_equal "https://example.com", ripple.url
  end
  
  test "urls missing .* are invalid" do
    ripple = Ripple.new(name:     "Test User",
                        url:      "https://example",
                        message:  "This is a test message.")
    assert ripple.invalid?
    assert ripple.errors[:url].any?
  end
  
end
