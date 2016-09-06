require_dependency 'time_entry'

module TimeEntryPatch
  def self.included(base)
    # base.extend(ClassMethods)

    # base.send(:include, InstanceMethods)

    base.class_eval do
      safe_attributes 'hours', 'comments', 'project_id', 'issue_id',
                      'activity_id', 'spent_on', 'custom_field_values',
                      'custom_fields', 'user_id'
    end
  end
  #
  # module ClassMethods
  # end

  # module InstanceMethods
  # end
end

# Add module to User
TimeEntry.send(:include, TimeEntryPatch)
