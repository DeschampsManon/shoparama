class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_path, notice: t('successfully_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to admin_categories_path, notice: t('successfully_destroyed') }
      end
    end
  end

  private
    def set_admin_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(
        :name
      )
    end
end