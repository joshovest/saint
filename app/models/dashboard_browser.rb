class DashboardBrowser < ActiveRecord::Base
  validates :name, presence:true
  validates :visits, presence:true
  validates :start_date, presence:true
end
