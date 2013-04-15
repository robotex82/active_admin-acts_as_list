require 'active_admin'

require 'active_admin/acts_as_list/engine'
require 'active_admin/acts_as_list/version'
require 'active_admin/acts_as_list/helper'

module ActiveAdminActsAsList
end

ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::ActsAsList::Helper
ActiveAdmin::Views::IndexAsTable.send :include, ActiveAdmin::ActsAsList::Helper
ActiveAdmin::Views::Pages::Show.send :include, ActiveAdmin::ActsAsList::Helper
