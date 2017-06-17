class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
  end

  def create
  end

  def update
    respond_to do |format|
    end
  end

  def destroy

  end

  private
    def set_admin_category
      @category = User.find(params[:id])
    end

    def user_params
      params.require(:category).permit(
        :name
      )
    end
end