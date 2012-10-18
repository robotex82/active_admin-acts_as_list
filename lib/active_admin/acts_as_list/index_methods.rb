module ActiveAdmin
  module ActsAsList
    module IndexMethods
      
      # Call this inside your index do...end bock to make your resource sortable.
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
        column "Placement" do |resource|
          
          actions = ActiveSupport::SafeBuffer.new
          
          unless resource.first?
            
            # Move to top
            actions << link_to([:move_to_top, active_admin_namespace.name, resource], class: :acts_as_list_arrow, title: I18n.t('acts_as_list.hovers.move_to_top')) do
              image_tag("acts_as_list/move_to_top.png")
            end
            
            actions << link_to([:move_up, active_admin_namespace.name, resource], class: :acts_as_list_arrow, title: I18n.t('acts_as_list.hovers.move_up')) do
              image_tag("acts_as_list/move_up.png")
            end
            
          end
          
          unless resource.last?
            
            # Move to bottom
            actions << link_to([:move_to_bottom, active_admin_namespace.name, resource], class: :acts_as_list_arrow, title: I18n.t('acts_as_list.hovers.move_to_bottom')) do
              image_tag("acts_as_list/move_to_bottom.png")
            end
            
            # Move down
            actions << link_to([:move_down, active_admin_namespace.name, resource], class: :acts_as_list_arrow, title: I18n.t('acts_as_list.hovers.move_down')) do
              image_tag("acts_as_list/move_down.png")
            end
          end
          
          actions

        end
      end
      
    end
  end
end