module ActiveAdmin
  module ActsAsList
    module Helper
      # Call this inside your index do...end bock to make your resource sortable.
      #
      # Example:
      #
      # #app/admin/players.rb
      #
      #  ActiveAdmin.register Player do
      #    index do
      #      # This adds columns for moving up, down, top and bottom.
      #      sortable_column
      #      #...
      #      column :firstname
      #      column :lastname
      #      default_actions
      #    end
      #  end
      def sortable_column
        column '' do |resource|
          default_path = "#{active_admin_namespace.name}_#{resource.class.model_name.to_s.underscore.gsub("/", "_")}_path"

          actions = ActiveSupport::SafeBuffer.new

          unless resource.first?
            # Move to top
            actions << link_to('&#9650;&#9650; '.html_safe, self.send(:"move_to_top_#{default_path}", resource), class: 'arrow')
            # Move up
            actions << link_to('&#9650; '.html_safe, self.send(:"move_up_#{default_path}", resource), class: 'arrow')
          end

          unless resource.last?
            # Move down
            actions << link_to('&#9660; '.html_safe, self.send(:"move_down_#{default_path}", resource), class: 'arrow')
            # Move to bottom
            actions << link_to('&#9660;&#9660; '.html_safe, self.send(:"move_to_bottom_#{default_path}", resource), class: 'arrow')
          end

          actions
        end
      end


      # Call this inside your resource definition to add the needed member actions
      # for your sortable resource.
      #
      # Example:
      #
      # #app/admin/players.rb
      #
      #  ActiveAdmin.register Player do
      #    # Sort players by position
      #    config.sort_order = 'position'
      #
      #    # Add member actions for positioning.
      #    sortable_member_actions
      #  end
      def sortable_member_actions
       member_action :move_to_top do
          if resource.first?
            redirect_to :back, :notice => I18n.t('acts_as_list.illegal_move_to_top', :resource => resource_class.to_s.camelize.constantize.model_name.human )
            return
          end

          resource.move_to_top
          redirect_to :back, :notice => I18n.t('acts_as_list.moved_to_top', :resource => resource_class.to_s.camelize.constantize.model_name.human )
        end

        member_action :move_to_bottom do
          if resource.last?
            redirect_to :back, :notice => I18n.t('acts_as_list.illegal_move_to_bottom', :resource => resource_class.to_s.camelize.constantize.model_name.human )
            return
          end

          resource.move_to_bottom
          redirect_to :back, :notice => I18n.t('acts_as_list.moved_to_bottom', :resource => resource_class.to_s.camelize.constantize.model_name.human )
        end

        member_action :move_up do
          if resource.first?
            redirect_to :back, :notice => I18n.t('acts_as_list.illegal_move_up', :resource => resource_class.to_s.camelize.constantize.model_name.human )
            return
          end

          resource.move_higher
          redirect_to :back, :notice => I18n.t('acts_as_list.moved_up', :resource => resource_class.to_s.camelize.constantize.model_name.human )
        end

        member_action :move_down do
          if resource.last?
            redirect_to :back, :notice => I18n.t('acts_as_list.illegal_move_down', :resource => resource_class.to_s.camelize.constantize.model_name.human )
            return
          end

          resource.move_lower
          redirect_to :back, :notice => I18n.t('acts_as_list.moved_down', :resource => resource_class.to_s.camelize.constantize.model_name.human )
        end
      end
    end
  end
end
