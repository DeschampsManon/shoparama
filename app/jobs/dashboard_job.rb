class DashboardJob < ActiveJob::Base
  queue_as :dashboard

  def perform(nb_day = 0)
    start_date = Time.now.to_datetime - (nb_day).day
    nb_users = User.where("created_at <= ?", start_date).count
    nb_products = Product.where("created_at <= ?", start_date).count
    nb_login = UserLogin.where("created_at <= ?", start_date).count
    nb_products_amazon = ProductSeller.where(website: "amazon").count
    nb_products_ebay = ProductSeller.where(website: "ebay").count

    Admin::Dashboard.find_or_create_by(created_at: start_date).update!(
        nb_users: nb_users,
        nb_products: nb_products,
        nb_login: nb_login,
        nb_products_amazon: nb_products_amazon,
        nb_products_ebay: nb_products_ebay)
  end
end
