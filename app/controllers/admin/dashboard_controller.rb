class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized?, if: :current_user

  def index
    @dashboard = Dashboard.where(job_date: Date.today - (1).day).first
    @dashboard_last_week = Dashboard.where(job_date: Date.today.beginning_of_week - (1).day).first

    partners = ['ebay', 'amazon']
    @data_partners_products_quantity = []
    partners.each do |partner|
      @data_partners_products_quantity << {name: partner, y: @dashboard.send("nb_products_#{partner}")}
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