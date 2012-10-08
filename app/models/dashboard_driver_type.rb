class DashboardDriverType < ActiveRecord::Base
  validates :driver_type, presence:true
  validates :visits, presence:true
  validates :form_completes, presence:true
  validates :start_date, presence:true
end
