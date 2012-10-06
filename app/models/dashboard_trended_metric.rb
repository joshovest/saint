class DashboardTrendedMetric < ActiveRecord::Base
  validates :date, presence:true
  validates :visits, presence:true
  validates :form_completes, presence:true
end
