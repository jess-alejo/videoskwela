require "test_helper"

class CourseCreatorControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get course_creator_show_url
    assert_response :success
  end
end
