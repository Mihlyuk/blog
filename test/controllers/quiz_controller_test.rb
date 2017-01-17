require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get solver" do
    get quiz_solver_url
    assert_response :success
  end

end
