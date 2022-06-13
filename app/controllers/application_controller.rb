class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :update_allowed_parameters, if: :devise_controller?
  
  def route_not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end


end
