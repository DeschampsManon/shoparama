class DashboardJob < ActiveJob::Base
  queue_as :dashboard

  def perform(nb_day = 1)

    yesterday = Time.now - 1.day
    start_date = yesterday.beginning_of_day
    end_date = yesterday.end_of_day

    nb_users = User.where(["created_at >= ? AND created_at <= ?", start_date, end_date]).count
    nb_products = Product.where(["created_at >= ? AND created_at <= ?", start_date, end_date]).count
    nb_login = Visit.where(["created_at >= ? AND created_at <= ?", start_date, end_date]).count
    job_date = Date.today

    Dashboard.find_or_create_by(job_date: yesterday).update!(
      nb_users: nb_users,
      nb_products: nb_products,
      nb_login: nb_login)
  end
end


