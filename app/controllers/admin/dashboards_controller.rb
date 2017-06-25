class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user

  def index
    start_date = Time.now.to_datetime
    @dashboard = Admin::Dashboard.where("created_at <= ?", start_date).last
    @dashboard_last_week = Admin::Dashboard.where("created_at <= ?", start_date.beginning_of_week - (1).day).last
    @charts = Admin::BlockChart.all

    @data_partners_products_quantity = []
    PARTNERS.each do |partner|
      @data_partners_products_quantity << {name: partner, y: @dashboard.send("nb_products_#{partner}")} rescue nil
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

  def change_block_chart
    data = JSON.parse(params[:data])
    data.each do |chart|
      block_chart = Admin::BlockChart.find(chart['id'])
      block_chart.x = chart['x']
      block_chart.y = chart['y']
      block_chart.width = chart['width']
      block_chart.height = chart['height']
      block_chart.save!
    end
    render :nothing => true
  end

  def remove_chart_from_dashboard
    block_chart = Admin::BlockChart.find(params['id'])
    block_chart.presence = false
    block_chart.save!
    redirect_to :back, notice: t('successfully_destroyed')
  end
end