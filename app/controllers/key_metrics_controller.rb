class KeyMetricsController < ApplicationController
  def index
  end
  
  def load
    require 'omni'
    
    @client = ROmniture::Client.new(
      Saint::Application.config.omni_username,
      Saint::Application.config.omni_secret,
      :dallas,
      verify_mode:nil,
      log:false,
      wait_time:25
    )
    
    t_end = Time.new
    t_start = t_end - (60*60*24*60)
    
    @rpt = @client.make_request "Report.GetOvertimeReport", {
      "reportDescription" => {
        "reportSuiteID" => "salesforcemarketing",
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "dateGranularity" => "day",
        "metrics" => [
          {"id" => "visits"},
          {"id" => "event17"}
        ],
        "segment_id" => "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
      }
    }
    
  end
end
