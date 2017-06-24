require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every 1.day, 'DashboardJob', at: '03:00' do
    DashboardJob.perform_later
  end
end