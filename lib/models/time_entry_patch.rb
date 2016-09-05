require_dependency 'time_entry'

module TimeEntryPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    base.class_eval do
      safe_attributes 'hours', 'comments', 'project_id', 'issue_id',
                      'activity_id', 'spent_on', 'custom_field_values',
                      'custom_fields', 'user_id'
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def safe_attributes=(attrs)
      user = attrs.nil? || attrs[:user_id].nil? ? User.current : User.find(attrs[:user_id])

      if attrs
        attrs = super(attrs)
        if issue_id_changed? && issue
          if issue.visible?(user) && user.allowed_to?(:log_time, issue.project)
            if attrs[:project_id].blank? && issue.project_id != project_id
              self.project_id = issue.project_id
            end
            @invalid_issue_id = nil
          else
            @invalid_issue_id = issue_id
          end
        end
      end

      attrs
    end
  end
end

# Add module to User
TimeEntry.send(:include, TimeEntryPatch)
