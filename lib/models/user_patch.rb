require_dependency 'user'

module UserPatch
  def self.included(base)
    base.extend(ClassMethods)

    # base.send(:include, InstanceMethods)

    base.class_eval do
      # include belongs_to
    end
  end

  module ClassMethods
    def in_project(project_ids)
      if project_ids.nil?
        all
      else
        includes(:members).where('members.project_id' => project_ids)
      end
    end
  end

  # module InstanceMethods
  # end
end

# Add module to User
User.send(:include, UserPatch)
