class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :current_password, :password_confirmation, :avatar, :cover_banner])
    end

    def after_update_path_for(resource)
      users_my_profile_path
    end

    def after_sign_in_path_for(resource)
      users_my_profile_path
    end
end