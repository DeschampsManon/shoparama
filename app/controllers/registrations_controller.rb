class RegistrationsController < Devise::RegistrationsController
  flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
end