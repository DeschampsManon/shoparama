class UsersController < ApplicationController
  before_action :logged_in?

  def my_profile
    @user = current_user
  end
end
