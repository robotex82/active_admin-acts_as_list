require 'active_admin/acts_as_list/engine'
require 'active_admin/acts_as_list/version'
require 'active_admin/acts_as_list/dsl'
require 'active_admin/acts_as_list/index_methods'

module ActiveAdminActsAsList
end

::ActiveAdmin::DSL.send(:include, ActiveAdmin::ActsAsList::DSL)
::ActiveAdmin::Views::IndexAsTable.send(:include, ActiveAdmin::ActsAsList::IndexMethods)