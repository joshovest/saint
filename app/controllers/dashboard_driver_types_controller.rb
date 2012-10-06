class DashboardDriverTypesController < ApplicationController
  def index
  end
  
  def visits
    load if DashboardTrendedMetric.all.length == 0
    
    @dashboard_trended_metrics = DashboardTrendedMetric.all
  end
  
  def form_completes
    load if DashboardTrendedMetric.all.length == 0
    
    @dashboard_trended_metrics = DashboardTrendedMetric.all
  end
  
  def load
    require 'omni'
    
    suite_id = "salesforcemarketing"
    t_end = Time.new - (60*60*24*2)
    t_start = t_end - (60*60*24*59)
    metrics = [
    	{"id" => "visits"},
    	{"id" => "event17"}
    ]
    elements = [
      {
        "id" => "eVar27",
        "classification" => "Traffic Driver Type",
        "top" => "10"
      }
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    
    o = Omni.new
    if Rails.env.production?
      o.delay.load_driver_types(suite_id, metrics, segment, elements, t_start, t_end, granularity)
    else
      o.load_driver_types(suite_id, metrics, segment, elements, t_start, t_end, granularity)
    end
  end
end