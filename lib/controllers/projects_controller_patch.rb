module ProjectsControllerPatch
  def self.included(base)
    # base.extend(ClassMethods)

    # base.send(:include, InstanceMethods)

    base.class_eval do
      before_filter :find_project, except: [:index, :list, :new, :create, :copy, :members]
      before_filter :authorize, except: [:index, :list, :new, :create, :copy, :archive, :unarchive, :destroy, :members]

      def members
        @records = User.in_project(params[:id]).collect { |u| [u.name, u.id] }
        render json: @records
      end
    end
  end

  # module ClassMethods
  # end
  #
  # module InstanceMethods
  # end
end

ProjectsController.send(:include, ProjectsControllerPatch)
