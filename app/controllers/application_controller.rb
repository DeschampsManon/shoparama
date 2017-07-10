class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_current_user, if: :current_user
  after_action :ahoy_track

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
    def authorized?
      if !current_user.has_role? :admin
        redirect_to(root_url)
      end
    end

    def ahoy_track
      ahoy.track_visit
    end
end






