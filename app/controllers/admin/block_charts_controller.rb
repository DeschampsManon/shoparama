class Admin::BlockChartsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user
  before_action :set_admin_block_charts, only: [:show, :edit, :update, :destroy]

  def index
    @charts = Admin::BlockChart.all
  end

  def new
    @chart = Admin::BlockChart.new
  end

  def edit
  end

  def create
    @chart = Admin::BlockChart.new(block_chart_params)
    respond_to do |format|
      if @chart.save
        format.html { redirect_to admin_block_charts_path, notice: t('successfully_created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @chart.update(block_chart_params)
        format.html { redirect_to admin_block_charts_path, notice: t('successfully_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @chart.destroy
        format.html { redirect_to admin_block_charts_path, notice: t('successfully_destroyed') }
      end
    end
  end

  private
    def set_admin_block_charts
      @chart = Admin::BlockChart.find(params[:id])
    end

    def block_chart_params
      params.require(:admin_block_chart).permit(
          :name,
          :title,
          :x,
          :y,
          :width,
          :height,
          :prsence
      )
    end
end