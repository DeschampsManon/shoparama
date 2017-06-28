class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user
  before_action :get_charts_stats, only: [:index, :export_to_pdf]

  def index
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

  def add_block_chart_to_dashboard
    block_chart = Admin::BlockChart.find(params['id'])
    block_chart.presence = true
    block_chart.save!
    redirect_to :back, notice: t('successfully_added')
  end

  def export_to_pdf
    respond_to  do |format|
      format.pdf do
        render :pdf           => "dashboard_pdf",
               :layout        => "pdf",
               :title         => "Tableau de bord",
               :show_as_html  =>  params.key?('debug')
      end
    end
  end

  private
    def get_charts_stats
      start_date = Time.now.to_datetime
      @dashboard = Admin::Dashboard.where("created_at <= ?", start_date).last
      @dashboard_last_week = Admin::Dashboard.where("created_at <= ?", start_date.beginning_of_week - (1).day).last

      @data_partners_products_quantity = []
      PARTNERS.each do |partner|
        @data_partners_products_quantity << {name: partner, y: @dashboard.send("nb_products_#{partner}")} rescue nil
      end

      @data_amazon_products_visited_each_day = {}
      @data_ebay_products_visited_each_day = {}

      product_visited_start_date = Date.parse('june 25 2017')
      Admin::Dashboard.where("created_at >= ?", product_visited_start_date).each do |dashboard|
        @data_amazon_products_visited_each_day[dashboard.created_at.strftime("%d-%b").to_s] = dashboard.nb_products_amazon_visited
        @data_ebay_products_visited_each_day[dashboard.created_at.strftime("%d-%b").to_s] = dashboard.nb_products_ebay_visited
      end

      @most_popular_kewords = {}
      UserKeyword.all.each do |user_keyword|
        @most_popular_kewords[user_keyword.name] = user_keyword.counter
      end

      @data_windows_count = {}
      @data_mac_os_x_count = {}
      @data_linux_count = {}

      BROWSERS.each do |browser|
        @data_windows_count[browser] = Visit.where(browser: browser, os: "Windows").count
        @data_mac_os_x_count[browser] = Visit.where(browser: browser, os: "Mac OS X").count
        @data_linux_count[browser] = Visit.where(browser: browser, os: "Linux").count
      end

      @most_popular_products_count = FavoriteProduct.group(:product_seller_id).order('count_id DESC').limit(5).count(:id)

      @most_popular_products_name = []
      @most_popular_products_count.each do |key, value|
        product = ProductSeller.find(key)
        @most_popular_products_name << product.name
      end

      @charts = Admin::BlockChart.all
    end

end