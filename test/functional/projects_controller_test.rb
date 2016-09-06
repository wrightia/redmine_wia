require File.expand_path('../../test_helper', __FILE__)

class ProjectsControllerTest < ActionController::TestCase
  fixtures :projects, :versions, :users, :email_addresses, :roles, :members,
           :member_roles, :issues, :journals, :journal_details,
           :trackers, :projects_trackers, :issue_statuses,
           :enabled_modules, :enumerations, :boards, :messages,
           :attachments, :custom_fields, :custom_values, :time_entries,
           :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions

  def test_members
    @request.session[:user_id] = 1

    post :members, project_id: 1
    assert_response :success
  end
end
