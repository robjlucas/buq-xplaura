class ApplicationController < ActionController::Base
  include Clearance::Controller

  def self.view_accessor(*names)
    attr_accessor(*names)
    helper_method(*names)
  end
end
