class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, if: :current_user

  def after_sign_in_path_for(resource)
    users_my_profile_path
  end

  def set_current_user
    User.current_user = current_user
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
  end

  private
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

  protected
    def logged_in?
      if !user_signed_in?
        redirect_to new_user_registration_path
      end
    end

    def authorized?
      if !current_user.has_role? :admin
        redirect_to(root_url)
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :current_password, :password_confirmation, :avatar])
    end
end






