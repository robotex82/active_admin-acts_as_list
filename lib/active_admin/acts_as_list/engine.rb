module ActiveAdmin
  module ActsAsList
    class Engine < Rails::Engine
      paths["config/locales"] << File.dirname(__FILE__) + '/../../../config/locales'
    end
  end  
end    
