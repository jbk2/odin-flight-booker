require "test_helper"

class FlightsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get flights_search_url
    assert_response :success
  end
end
