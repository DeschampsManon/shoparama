class DashboardJob < ActiveJob::Base
  queue_as :dashboard

  def perform()

    yesterday = Date.today - (1).day

    nb_users = User.all.count
    nb_products = Product.all.count
    nb_login = Visit.all.count
    nb_products_amazon = ProductSeller.where(website: "amazon").count
    nb_products_ebay = ProductSeller.where(website: "ebay").count

    Dashboard.find_or_create_by(job_date: yesterday).update!(
      nb_users: nb_users,
      nb_products: nb_products,
      nb_login: nb_login,
      nb_products_amazon: nb_products_amazon,
      nb_products_ebay: nb_products_ebay)

  end
end
