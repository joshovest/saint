class DashboardBrowsersController < ApplicationController
  def visits
    load if DashboardBrowser.all.length == 0
    
    @dashboard_browsers = DashboardBrowser.find(:all, :order => "start_date DESC, visits DESC")
  end
  
  def load
    require 'omni'
    
    suite_id = "salesforcemarketing"
    elements = [
      [
        {
          "id" => "browser",
          "top" => "10"
        }
      ],
      [
        {
          "id" => "mobileDeviceName",
          "top" => "5"
        }
      ]
    ]
    t_end = [
      Time.new.to_date - 2,
      Time.new.to_date - 32
    ]
    metrics = [
      [
        {"id" => "visits"}
      ],
      [
        {"id" => "mobileVisits"}
      ]
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    
    o = Omni.new
    count = 0
    t_end.each do |t|
      if Rails.env.production?
        o.delay.load_browsers(suite_id, metrics, segment, elements, t - 30, t, count == 0)
      else
        o.load_browsers(suite_id, metrics, segment, elements, t - 30, t, count == 0)
      end
      count += 1
    end
  end
end