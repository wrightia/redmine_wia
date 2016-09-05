module TimelogControllerPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    base.class_eval do
      def create_with_plugin
        @time_entry ||= TimeEntry.new(project: @project,
                                      issue: @issue,
                                      user: User.find(params[:time_entry][:user_id]),
                                      spent_on: User.current.today) unless params[:time_entry][:user_id].blank?

        create_without_plugin
      end

      def update_with_plugin
        @time_entry[:user_id] = params[:time_entry][:user_id] unless params[:time_entry][:user_id].blank?

        update_without_plugin
      end

      alias_method_chain :create, :plugin
      alias_method_chain :update, :plugin
    end
  end

  module ClassMethods
  end

  module InstanceMethods
  end
end

TimelogController.send(:include, TimelogControllerPatch)
