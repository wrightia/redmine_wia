require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
  fixtures :users, :email_addresses, :members, :projects, :roles, :member_roles, :auth_sources,
            :trackers, :issue_statuses,
            :projects_trackers,
            :watchers,
            :issue_categories, :enumerations, :issues,
            :journals, :journal_details,
            :groups_users,
            :enabled_modules,
            :tokens

  def test_users_in_project
    assert_kind_of Array, User.in_project(1).map(&:id)
  end
end
