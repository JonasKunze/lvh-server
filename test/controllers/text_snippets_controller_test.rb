require 'test_helper'

class TextSnippetsControllerTest < ActionController::TestCase
  test "should get json" do
    get :json
    assert_response :success
  end

end
