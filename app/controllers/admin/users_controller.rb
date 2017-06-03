class Admin::UsersController < ApplicationController
  before_action :logged_in?
  before_action :authorized?, if: :current_user
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      generated_password = Devise.friendly_token.first(8)
      @user.password = generated_password
      @user.add_role params[:user][:roles]
      if @user.save
        UserMailer.welcome(@user, generated_password).deliver
        format.html { redirect_to admin_users_url, notice: t('.successfully_created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @user.roles = []
      @user.add_role params[:user][:roles]
      if @user.update(user_params)
        format.html { redirect_to admin_users_url, notice: t('.successfully_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to admin_users_path, notice: t('successfully_destroyed') }
      end
    end
  end

  private
    def set_admin_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
          :email,
          :first_name,
          :last_name,
          :avatar,
      )
    end
end