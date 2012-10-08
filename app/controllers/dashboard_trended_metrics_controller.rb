class DashboardTrendedMetricsController < ApplicationController
  def index
  end
  
  def visits
    load if DashboardTrendedMetric.all.length == 0
    
    @dashboard_trended_metrics = DashboardTrendedMetric.find(:all, :order => "date DESC")
  end
  
  def form_completes
    load if DashboardTrendedMetric.all.length == 0
    
    @dashboard_trended_metrics = DashboardTrendedMetric.find(:all, :order => "date DESC")
  end
  
  def load
    require 'omni'
    
    suite_id = "salesforcemarketing"
    t_end = Time.new.to_date - 2
    t_start = t_end - 59
    metrics = [
      {"id" => "visits"},
      {"id" => "event17"}
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    granularity = "day"
    
    o = Omni.new
    if Rails.env.production?
      flash[:success] = "Data has been re-requested."
      o.delay.load_trended_metrics(suite_id, metrics, segment, t_start, t_end, granularity)
    else
      o.load_trended_metrics(suite_id, metrics, segment, t_start, t_end, granularity)
    end
  end
end