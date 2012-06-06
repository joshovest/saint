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
    #sites = Site.find(:all)
    s = Site.find(:last)
    
    #sites.each do |s|
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
      
        #per_page = 5000
        per_page = 100
        current_page = 0
        current_rows = 0
        saint_row = 0
        @saint_table = Array.new
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
                @html += "<tr><th colspan=\"13\">New Report - page #{current_page}</th></tr>"
              
                current_rows = unclassified_rpt["report"]["data"][0]["breakdown"].length
                unclassified_rpt["report"]["data"][0]["breakdown"].each do |row|
			      row["name"] = row["name"].gsub("%/", "/")
			      row["name"] = HTMLEntities.new.decode row["name"]
			      
			      saint_row = Classification.new({key: row["name"]})
			      @saint_table << {row: saint_row.get_row}
			      if saint_row.valid?
			        @html += "<tr>"
			        @html += "<td>#{saint_row["key"]}</td>"
			        @html += "<td>#{saint_row["type"]}</td>"
			        @html += "<td>#{saint_row["name"]}</td>"
			        @html += "<td>#{saint_row["tld"]}</td>"
			        @html += "<td>#{saint_row["name"]}</td>"
			        @html += "<td>#{saint_row["country"]}</td>"
			        @html += "<td>#{saint_row["branded"]}</td>"
			        @html += "<td>#{saint_row["keyword_cloud"]}</td>"
			        @html += "<td>#{saint_row["display_country"]}</td>"
			        @html += "<td>#{saint_row["display_site"]}</td>"
			        @html += "<td>#{saint_row["display_product"]}</td>"
			        @html += "<td>#{saint_row["display_date"]}</td>"
			        @html += "<td>#{saint_row["driver_id"]}</td>"
			        @html += "</tr>"
			      else
			        @html += "<tr><td colspan=\"13\"><strong>#{saint_row["name"]}</strong></td></tr>"
			      end
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
        #end while current_rows >= per_page
        end while current_page < 1
      
        @html += "</table>"
      end
    #end
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
