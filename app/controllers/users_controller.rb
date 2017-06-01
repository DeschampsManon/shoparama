class UsersController < ApplicationController
  before_action :user_signed_in

  def my_profile
    @user = current_user
  end
end
