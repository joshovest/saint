class DashboardOfferType < ActiveRecord::Base
  validates :name, presence:true
  validates :form_views, presence:true
  validates :form_completes, presence:true
  validates :start_date, presence:true
  
  def form_complete_rate
    rate = ((self.form_completes.to_f / self.form_views) * 100).round(1)
  end
end
