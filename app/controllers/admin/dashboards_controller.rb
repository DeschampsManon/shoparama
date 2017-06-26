class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user

  def index
    start_date = Time.now.to_datetime
    @dashboard = Admin::Dashboard.where("created_at <= ?", start_date).last
    @dashboard_last_week = Admin::Dashboard.where("created_at <= ?", start_date.beginning_of_week - (1).day).last

    @data_partners_products_quantity = []
    PARTNERS.each do |partner|
      @data_partners_products_quantity << {name: partner, y: @dashboard.send("nb_products_#{partner}")} rescue nil
    end

    @data_amazon_products_visited_each_day = {}
    @data_ebay_products_visited_each_day = {}

    product_visited_start_date = Date.parse('june 23 2017')
    Admin::Dashboard.where("created_at >= ?", product_visited_start_date).each do |dashboard|
      @data_amazon_products_visited_each_day[dashboard.created_at.strftime("%d-%b").to_s] = dashboard.nb_products_amazon_visited
      @data_ebay_products_visited_each_day[dashboard.created_at.strftime("%d-%b").to_s] = dashboard.nb_products_ebay_visited
    end

    @charts = Admin::BlockChart.all
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