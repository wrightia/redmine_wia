# Load the Redmine helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

class ProjectsControllerTest < ActionController::TestCase
  fixtures :projects

  def test_members
    post :members, id: 1
    assert_response :success
  end
end
