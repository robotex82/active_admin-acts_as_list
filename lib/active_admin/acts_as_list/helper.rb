module ActiveAdmin
  module ActsAsList
    module Helper
      # Call this inside your index do...end block to make your resource sortable.
      #
      # Example:
      #
      # #app/admin/players.rb
      #
      #  ActiveAdmin.register Player do
      #    index do
      #      # This adds columns for moving up, down, top and bottom.
      #      sortable_columns
      #      #...
      #      column :firstname
      #      column :lastname
      #      default_actions
      #    end
      #  end
      def sortable_columns
        include_column_move_to_top
        include_column_move_up
        include_column_move_down
        include_column_move_to_bottom
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
        include_member_action_move_to_top
        include_member_action_move_to_bottom
        include_member_action_move_up
        include_member_action_move_down
      end

      private

      def include_column_move_to_top
        column "&#9650;&#9650;".html_safe do |resource|
          link_to("&#9650;&#9650;".html_safe, generate_path_for_action(:move_to_top, resource), :class => "arrow") unless resource.first?
        end
      end

      def include_column_move_up
        column "&#9650;".html_safe do |resource|
          link_to("&#9650;".html_safe, generate_path_for_action(:move_up, resource), :class => "arrow") unless resource.first?
        end
      end

      def include_column_move_down
        column "&#9660;".html_safe do |resource|
          link_to("&#9660;".html_safe, generate_path_for_action(:move_down, resource), resource), :class => "arrow") unless resource.last?
        end
      end

      def include_column_move_to_bottom
        column "&#9660;&#9660;".html_safe do |resource|
          link_to("&#9660;&#9660;".html_safe, generate_path_for_action(:move_to_bottom, resource), resource), :class => "arrow") unless resource.last?
        end
      end

      def include_member_action_move_to_top
        member_action :move_to_top do
          if resource.first?
            redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.illegal_move_to_top')
            return
          end

          resource.move_to_top
          redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.moved_to_top')
        end
      end

      def include_member_action_move_to_bottom
        member_action :move_to_bottom do
          if resource.last?
            redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.illegal_move_to_bottom')
            return
          end

          resource.move_to_bottom
          redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.moved_to_bottom')
        end
      end

      def include_member_action_move_up
        member_action :move_up do
          if resource.first?
            redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.illegal_move_up')
            return
          end

          resource.move_higher
          redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.moved_up')
        end
      end

      def include_member_action_move_down
        member_action :move_down do
          if resource.last?
            redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.illegal_move_down')
            return
          end

          resource.move_lower
          redirect_to :back, :notice => localize_notice(resource_class, 'acts_as_list.moved_down')
        end
      end

      def localize_notice(resource_class, locale_key)
        I18n.t(locale_key, :resource => resource_class.to_s.camelize.constantize.model_name.human )
      end

      def generate_path_for_action(action, resource)
        self.send("#{action}_admin_#{resource.class.model_name.underscore.gsub("/", "_")}_path".to_sym, resource)
      end

    end
  end
end
