class DashboardDriverType < ActiveRecord::Base
  validates :type, presence:true
  validates :visits, presence:true
  validates :form_completes, presence:true
end
