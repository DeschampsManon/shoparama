class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user

  def index
    @dashboard = Dashboard.all

    @nb_users = 0
    @nb_products = 0
    @nb_login = 0

    @dashboard.each do |stat|
      @nb_users += stat.nb_users
      @nb_products += stat.nb_products
      @nb_login += stat.nb_login
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end