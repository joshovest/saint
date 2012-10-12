class DashboardDriverTypesController < ApplicationController
  def visits
    load if !is_current_data?
    
    @dashboard_driver_types = DashboardDriverType.find(:all, :order => "start_date DESC, visits DESC")
  end
  
  def form_completes
    load if !is_current_data?
    
    @dashboard_driver_types = DashboardDriverType.find(:all, :order => "start_date DESC, form_completes DESC")
  end
  
  def is_current_data?
    if DashboardDriverType.all.length == 0
      cur = false
    elsif (DashboardDriverType.maximum(:start_date)+30) < 2.days.ago.to_date
      cur = false
    else
      cur = true
    end
    
    cur
  end
  
  def load
    require 'omni'
    
    suite_id = "salesforcemarketing"
    elements = [
      {
        "id" => "eVar27",
        "classification" => "Traffic Driver Type",
        "top" => "10"
      }
    ]
    t_end = [
      Time.new.to_date - 2,
      Time.new.to_date - 32
    ]
    metric_list = [
      "visits",
      "event17"
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    
    o = Omni.new
    count = 0
    t_end.each do |t|
      metric_list.each do |m|
        metrics = [
          {"id" => m}
        ]
        if Rails.env.production?
          o.delay.load_driver_types(suite_id, metrics, segment, elements, t - 30, t, count == 0)
        else
          o.load_driver_types(suite_id, metrics, segment, elements, t - 30, t, count == 0)
        end
        count += 1
      end
    end
  end
end