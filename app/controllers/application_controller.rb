class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin_user!
    if !current_user.present? || !current_user.admin?
      redirect_to new_user_session_path 
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :gender
    devise_parameter_sanitizer.for(:account_update) << :name << :gender
  end


end
