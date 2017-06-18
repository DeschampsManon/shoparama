class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user

  def index
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