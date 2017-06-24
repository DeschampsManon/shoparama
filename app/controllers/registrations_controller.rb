class RegistrationsController < Devise::RegistrationsController
  protected
    def after_update_path_for(resource)
      users_my_profile_path
    end
end