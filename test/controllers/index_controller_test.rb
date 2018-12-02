require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get index_Index_url
    assert_response :success
  end

end
