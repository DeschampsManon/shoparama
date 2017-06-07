class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_profile
    @user = current_user
  end
end
