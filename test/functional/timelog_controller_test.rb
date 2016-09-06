require File.expand_path('../../test_helper', __FILE__)

class TimelogControllerTest < ActionController::TestCase
  fixtures :projects, :enabled_modules, :roles, :members,
           :member_roles, :issues, :time_entries, :users,
           :trackers, :enumerations, :issue_statuses,
           :custom_fields, :custom_values,
           :projects_trackers, :custom_fields_trackers,
           :custom_fields_projects

  def test_create
    @request.session[:user_id] = 3
    assert_difference 'TimeEntry.count' do
      post :create, :project_id => 1,
                    :time_entry => {:comments => 'Some work on TimelogControllerTest',
                                    :activity_id => '11',
                                    :spent_on => '2008-03-14',
                                    :issue_id => '1',
                                    :hours => '7.3',
                                    :user_id => 2 }
      assert_redirected_to '/projects/ecookbook/time_entries'
    end

    t = TimeEntry.order('id DESC').first

    assert_equal 2, t.user_id
  end

  def test_update
    entry = TimeEntry.find(1)
    assert_equal 1, entry.issue_id
    assert_equal 2, entry.user_id

    @request.session[:user_id] = 1
    put :update, :id => 1,
                 :time_entry => {:issue_id => '2',
                                :hours => '8',
                                :user_id => 2 }
    assert_redirected_to :action => 'index', :project_id => 'ecookbook'
    entry.reload

    assert_equal 2, entry.user_id
  end
end
