class ScrapeJob < ActiveJob::Base
  queue_as :scrape

  def perform()

  end
end
