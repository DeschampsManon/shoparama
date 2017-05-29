class UsersController < ApplicationController
  before_filter :authenticate_user!

  def my_profile
    @user = current_user
  end
end
