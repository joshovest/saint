class ClassifierController < ApplicationController
  def index
    require 'htmlentities'
    
    # create client w/ credentials
    @client = ROmniture::Client.new(
      Saint::Application.config.omni_username,
      Saint::Application.config.omni_secret,
      :dallas,
      verify_mode:nil,
      log:false,
      wait_time:25
    )
    
    @html = ""
    sites = Site.find(:all)
    sites.each do |s|
      suite = s.suite_list.split(",").first
      none_rpt = @client.get_report "Report.QueueRanked", get_params(suite, [
        {
       	  "id" => "eVar27",
       	  "classification" => "Traffic Driver Type",
       	  "top" => 20
        }
      ])
      none_row = 0
      if !none_rpt["report"].nil?
        if !none_rpt["report"]["data"].nil?
          none_rpt["report"]["data"].each do |row|
            none_row += 1
            break if row["name"] == "::unspecified::"
          end
        end
      end
    
      if none_row > 0
        @html += "<h2>Unclassified Rows for <em>#{s.name}</em></h2>"
	    @html += "<table cellpadding=\"1\" cellspacing=\"1\" border=\"1\">"
      
        per_page = 5000
        current_page = 0
        current_rows = 0
        saint_row = 0
        begin
          failure = false
          current_page += 1
          unclassified_rpt = @client.get_report "Report.QueueRanked", get_params(suite, [
            {
              "id" => "eVar27",
              "classification" => "Traffic Driver Type",
              "top" => 1,
              "startingWith" => none_row
            },
            {
              "id" => "eVar27",
              "top" => per_page,
              "startingWith" => current_page == 1 ? current_page : ((current_page * per_page) + 1)
            }
          ])
        
          if !unclassified_rpt["report"].nil?
            if !unclassified_rpt["report"]["data"].nil?
              if !unclassified_rpt["report"]["data"][0]["breakdown"].nil?
                @html += "<tr><th colspan=\"15\">New Report - page #{current_page}</th></tr>"
              
                current_rows = unclassified_rpt["report"]["data"][0]["breakdown"].length
                unclassified_rpt["report"]["data"][0]["breakdown"].each do |row|
			      row["name"] = row["name"].gsub("%/", "/")
			      row["name"] = HTMLEntities.new.decode row["name"]
			      @html += "<tr><td>#{row["name"]}</td></tr>"
                end
              else
                failure = true
              end
            else
              failure = true
            end
          else
            failure = true
          end
        
          if failure == true
            @html += "<tr><th colspan=\"15\">*** FAILURE on page #{current_page}! ***</th></tr>"
          end
        end while current_rows >= per_page
        #end while current_page <= 2
      
        @html += "</table>"
      end
    end
  end
  
  def get_params(suite, els)
    t_start = Time.new
    t_end = t_start - (60*60*24*30)
    params = {
      "reportDescription" => {
        "reportSuiteID" => suite,
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "metrics" => [
          {"id" => "event11"}
        ],
        "elements" => els
      }
    }
    params
  end
end
