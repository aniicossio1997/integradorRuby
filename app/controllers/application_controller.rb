class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[:email])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[email])

    end
  def after_sign_in_path_for(resource)
    (resource.id == current_user.id) ? logged_in_root_path : root_path
  end

  def after_sign_out_path_for(resource_or_scope) 
    user_signed_in? ? logged_in_root_path : root_path
  end

end
