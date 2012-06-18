require 'test_helper'

module ActiveAdmin
  class ActsAsListTest < ActiveSupport::TestCase
    test "truth" do
      assert_kind_of Module, ActiveAdmin::ActsAsList
    end
  end  
end
