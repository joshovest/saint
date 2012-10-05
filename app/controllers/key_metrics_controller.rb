class KeyMetricsController < ApplicationController
  def index
  end
  
  def visits
    load if KeyMetric.all.length == 0
    
    @key_metrics = KeyMetric.all
  end
  
  def form_completes
    load if KeyMetric.all.length == 0
    
    @key_metrics = KeyMetric.all
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
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    granularity = "day"
    
    o = Omni.new
    if Rails.env.production?
      o.delay.load_new(suite_id, metrics, segment, t_start, t_end, granularity)
    else
      o.load_new(suite_id, metrics, segment, t_start, t_end, granularity)
    end
  end
end