if defined?(ActiveAdmin)
  module ActsAsList
    module ActiveAdminHelper
      def sortable_columns
        column "&#9650;&#9650;".html_safe do |resource|
          link_to("&#9650;&#9650;".html_safe, self.send(:"move_to_top_admin_#{resource.class.model_name.underscore.gsub("/", "_")}_path", resource), :class => "arrow") unless resource.first?
        end
        column "&#9650;".html_safe do |resource|
          link_to("&#9650;".html_safe, self.send(:"move_up_admin_#{resource.class.model_name.underscore.gsub("/", "_")}_path", resource), :class => "arrow") unless resource.first?
        end
        column "&#9660;".html_safe do |resource|
          link_to("&#9660;".html_safe, self.send(:"move_down_admin_#{resource.class.model_name.underscore.gsub("/", "_")}_path", resource), :class => "arrow") unless resource.last?
        end
        column "&#9660;&#9660;".html_safe do |resource|
          link_to("&#9660;&#9660;".html_safe, self.send(:"move_to_bottom_admin_#{resource.class.model_name.underscore.gsub("/", "_")}_path", resource), :class => "arrow") unless resource.last?
        end
      end
      
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
