class DashboardCloud < ActiveRecord::Base
  validates :name, presence:true
  validates :page_views, presence:true
  validates :form_completes, presence:true
  validates :start_date, presence:true
end
