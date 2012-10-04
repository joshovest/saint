class KeyMetricsController < ApplicationController
  def index
    @key_metrics = KeyMetric.all
  end
  
  def load
    require 'omni'
    
    suite_id = "salesforcemarketing"
    t_end = Time.new - (60*60*24)
    t_start = t_end - (60*60*24*60)
    metrics = [
    	{"id" => "visits"},
    	{"id" => "event17"}
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    granularity = "day"
    
    o = Omni.new
    o.delay.load_new(suite_id, metrics, segment, t_start, t_end, granularity)
    redirect_to key_metrics_path
  end
end
