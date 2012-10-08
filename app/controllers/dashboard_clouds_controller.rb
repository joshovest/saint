class DashboardCloudsController < ApplicationController
  def page_views
    load if DashboardCloud.all.length == 0
    
    @dashboard_clouds = DashboardCloud.find(:all, :order => "start_date DESC, page_views DESC")
  end
  
  def form_completes
    load if DashboardCloud.all.length == 0
    
    @dashboard_clouds = DashboardCloud.find(:all, :order => "start_date DESC, page_views DESC")
  end
  
  def load
    require 'omni'
    
    suite_id = "salesforcemarketing"
    elements = [
      {
        "id" => "eVar35",
        "top" => "10"
      }
    ]
    t_end = [
      Time.new.to_date - 2,
      Time.new.to_date - 32
    ]
    metrics = [
      {"id" => "event11"},
      {"id" => "event17"}
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    
    o = Omni.new
    count = 0
    t_end.each do |t|
      if Rails.env.production?
        o.delay.load_clouds(suite_id, metrics, segment, elements, t - 30, t, count == 0)
      else
        o.load_clouds(suite_id, metrics, segment, elements, t - 30, t, count == 0)
      end
      count += 1
    end
  end
end