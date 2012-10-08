class DashboardVideoName < ActiveRecord::Base
  validates :name, presence:true
  validates :start_date, presence:true
  validates :video_starts, presence:true
  validates :video_completes, presence:true
end
