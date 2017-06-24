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