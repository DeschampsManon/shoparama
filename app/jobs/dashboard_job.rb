class DashboardJob < ActiveJob::Base
  queue_as :dashboard

  def perform(nb_day = 0)
    start_date = Time.now.to_datetime - (nb_day).day
    nb_users = User.where("created_at <= ?", start_date).count
    nb_products = Product.where("created_at <= ?", start_date).count
    nb_login = UserLogin.where("created_at <= ?", start_date).count
    nb_products_amazon = ProductSeller.where(website: "amazon").where("created_at <= ?", start_date).count
    nb_products_ebay = ProductSeller.where(website: "ebay").where("created_at <= ?", start_date).count

    products_visited = Ahoy::Event.where(name: "$click").where("properties->>'class' like ?", "%product-visited%").where("time <= ?", start_date)
    nb_products_amazon_visited = 0
    nb_products_ebay_visited = 0

    products_visited.each do |product_visited|
      product_id = product_visited.properties["id"].partition('product_').last
      product = ProductSeller.where(product_id: product_id ).first
      if product.website == "amazon"
        nb_products_amazon_visited += 1
      else
        nb_products_ebay_visited += 1
      end
    end

    Admin::Dashboard.find_or_create_by(created_at: start_date).update!(
        nb_users: nb_users,
        nb_products: nb_products,
        nb_login: nb_login,
        nb_products_amazon: nb_products_amazon,
        nb_products_ebay: nb_products_ebay,
        nb_products_amazon_visited: nb_products_amazon_visited,
        nb_products_ebay_visited: nb_products_ebay_visited)
  end
end
