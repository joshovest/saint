class Omni
  attr_accessor :client
  
  def initialize
    # create client w/ credentials
    @client = ROmniture::Client.new(
      Saint::Application.config.omni_username,
      Saint::Application.config.omni_secret,
      :dallas,
      verify_mode:nil,
      log:false,
      wait_time:25
    )
  end
  
  def load_trended_metrics(suite_id, metrics, segment, t_start, t_end, granularity)
    rpt = @client.get_report "Report.QueueOvertime", {
      "reportDescription" => {
        "reportSuiteID" => suite_id,
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "dateGranularity" => granularity,
        "metrics" => metrics,
        "segment_id" => segment || ""
      }
    }
    
    if !rpt["report"].nil?
      if !rpt["report"]["data"].nil?
        DashboardTrendedMetric.destroy_all
        rpt["report"]["data"].each do |row|
          r = DashboardTrendedMetric.new
          r.date = Date.new(row["year"], row["month"], row["day"])
          r.visits = row["counts"][0]
          r.form_completes = row["counts"][1]
          r.save
        end
      end
    end
  end
  
  def load_driver_types(suite_id, metrics, segment, elements, t_start, t_end, empty_table)
    rpt = @client.get_report "Report.QueueRanked", {
      "reportDescription" => {
        "reportSuiteID" => suite_id,
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "metrics" => metrics,
        "elements" => elements,
        "segment_id" => segment || ""
      }
    }
    
    if !rpt["report"].nil?
      if !rpt["report"]["data"].nil?
        DashboardDriverType.destroy_all if empty_table
        rpt["report"]["data"].each do |row|
          if row["name"] != "::unspecified::"
            if metrics[0]["id"] == "visits"
              r = DashboardDriverType.new
              r.driver_type = row["name"]
              r.start_date = t_start
              r.visits = row["counts"][0]
              r.form_completes = 0
            else
              r = DashboardDriverType.find_by_driver_type(row["name"], :conditions => { :start_date => (t_start-1)..(t_start+1) })
              r.form_completes = row["counts"][0] if !r.nil?
            end
            
            r.save if !r.nil?
          end
        end
      end
    end
  end
  
  def load_clouds(suite_id, metrics, segment, elements, t_start, t_end, empty_table)
    rpt = @client.get_report "Report.QueueRanked", {
      "reportDescription" => {
        "reportSuiteID" => suite_id,
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "metrics" => metrics,
        "elements" => elements,
        "segment_id" => segment || ""
      }
    }
    
    if !rpt["report"].nil?
      if !rpt["report"]["data"].nil?
        DashboardCloud.destroy_all if empty_table
        rpt["report"]["data"].each do |row|
          if row["name"] != "::unspecified::" && row["name"] != "No Cloud"
            r = DashboardCloud.new
            r.name = row["name"]
            r.start_date = t_start
            r.page_views = row["counts"][0]
            r.form_completes = row["counts"][1]
            r.save
          end
        end
      end
    end
  end
  
  def load_videos(suite_id, metrics, segment, elements, t_start, t_end, empty_table)
    rpt = @client.get_report "Report.QueueRanked", {
      "reportDescription" => {
        "reportSuiteID" => suite_id,
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "metrics" => metrics,
        "elements" => elements,
        "segment_id" => segment || ""
      }
    }
    
    if !rpt["report"].nil?
      if !rpt["report"]["data"].nil?
        DashboardVideoName.destroy_all if empty_table
        rpt["report"]["data"].each do |row|
          if row["name"] != "::unspecified::"
            r = DashboardVideoName.new
            r.name = row["name"]
            r.start_date = t_start
            r.video_starts = row["counts"][0]
            r.video_completes = row["counts"][1]
            r.save
          end
        end
      end
    end
  end
  
  def load_offer_types(suite_id, metrics, segment, elements, t_start, t_end, empty_table)
    rpt = @client.get_report "Report.QueueRanked", {
      "reportDescription" => {
        "reportSuiteID" => suite_id,
        "dateFrom" => t_start.strftime("%Y-%m-%d"),
        "dateTo" => t_end.strftime("%Y-%m-%d"),
        "metrics" => metrics,
        "elements" => elements,
        "segment_id" => segment || ""
      }
    }
    
    if !rpt["report"].nil?
      if !rpt["report"]["data"].nil?
        DashboardOfferType.destroy_all if empty_table
        rpt["report"]["data"].each do |row|
          if row["name"] != "::unspecified::" && row["name"] != "[NO OFFER ID]"
            r = DashboardOfferType.new
            r.name = row["name"]
            r.start_date = t_start
            r.form_views = row["counts"][0]
            r.form_completes = row["counts"][1]
            r.save
          end
        end
      end
    end
  end
  
  def load_browsers(suite_id, metrics, segment, elements, t_start, t_end, empty_table)
    for i in 0..(metrics.length - 1)
      rpt = @client.get_report "Report.QueueRanked", {
        "reportDescription" => {
          "reportSuiteID" => suite_id,
          "dateFrom" => t_start.strftime("%Y-%m-%d"),
          "dateTo" => t_end.strftime("%Y-%m-%d"),
          "metrics" => metrics[i],
          "elements" => elements[i],
          "segment_id" => segment || ""
        }
      }
    
      if !rpt["report"].nil?
        if !rpt["report"]["data"].nil?
          DashboardBrowser.destroy_all if (empty_table && i==0)
          rpt["report"]["data"].each do |row|
            if row["name"] != "::unspecified::"
              r = DashboardBrowser.new
              r.name = row["name"]
              r.start_date = t_start
              r.visits = row["counts"][0]
              r.save
            end
          end
        end
      end
    end
  end
  
  def classify(site)
    return if site.nil?
    
    require 'htmlentities'
    
    @msg = ""
    @html = ""
    failed = false
    user = User.order(:id).first
    suites = site.suite_list.split(",")
    none_rpt = @client.get_report "Report.QueueRanked", get_params(suites.first, [
      {
        "id" => "eVar27",
       	"classification" => "Traffic Driver Type",
       	#"id" => "trackingCode",
       	#"classification" => "Traffic Driver Original-Type",
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
    
    # limit match queries
    @cloud_matches = CloudMatch.find(:all, order: "position")
    @brand_matches = BrandMatch.find(:all, order: "position")
      
    saint_table = Array.new
    if none_row > 0
      @html += "<h2>Unclassified Rows for <em>#{site.name}</em></h2>\n"
	  @html += "<table cellpadding=\"1\" cellspacing=\"1\" border=\"1\">\n"
	    
      #per_page = 10
      per_page = 1000
      #current_page = 0
      current_page = 10
      current_rows = 0
      saint_row = 0
      begin
        failed = false
        current_page += 1
        unclassified_rpt = @client.get_report "Report.QueueRanked", get_params(suites.first, [
          {
            "id" => "eVar27",
            "classification" => "Traffic Driver Type",
            #"id" => "trackingCode",
            #"classification" => "Traffic Driver Original-Type",
            "top" => 1,
            "startingWith" => none_row
          },
          {
            "id" => "eVar27",
            #"id" => "trackingCode",
            "top" => per_page,
            "startingWith" => current_page == 1 ? current_page : ((current_page * per_page) + 1)
          }
        ])
        
        if !unclassified_rpt["report"].nil?
          if !unclassified_rpt["report"]["data"].nil?
            if !unclassified_rpt["report"]["data"][0]["breakdown"].nil?
              @html += "<tr><th colspan=\"14\">New Report - page #{current_page}</th></tr>\n"
              
              current_rows = unclassified_rpt["report"]["data"][0]["breakdown"].length
              unclassified_rpt["report"]["data"][0]["breakdown"].each do |row|
                row["name"] = "" if row["name"].nil?
                row["name"] = row["name"].gsub("%/", "/")
                row["name"] = HTMLEntities.new.decode row["name"]
                
                saint_row = Classification.new({key: row["name"]})
                saint_row.set_matches(@brand_matches, @cloud_matches)
                saint_table << {row: saint_row.get_row}
                
                if saint_row.valid?
                  @html += "<tr>\n"
                  @html += "<td>#{saint_table.count}</td>\n"
                  @html += "<td>#{saint_row["key"]}</td>\n"
                  @html += "<td>#{saint_row["type"]}</td>\n"
                  @html += "<td>#{saint_row["engine"]}</td>\n"
                  @html += "<td>#{saint_row["tld"]}</td>\n"
                  @html += "<td>#{saint_row["name"]}</td>\n"
                  @html += "<td>#{saint_row["country"]}</td>\n"
                  @html += "<td>#{saint_row["branded"]}</td>\n"
                  @html += "<td>#{saint_row["keyword_cloud"]}</td>\n"
                  @html += "<td>#{saint_row["display_country"]}</td>\n"
                  @html += "<td>#{saint_row["display_site"]}</td>\n"
                  @html += "<td>#{saint_row["display_product"]}</td>\n"
                  @html += "<td>#{saint_row["display_date"]}</td>\n"
                  @html += "<td>#{saint_row["driver_id"]}</td>\n"
                  @html += "</tr>\n"
                else
                  @html += "<tr><td colspan=\"13\"><strong>#{saint_row["name"]}</strong></td></tr>\n"
                end
              end
            else
              failed = true
            end
          else
            failed = true
          end
        else
          failed = true
        end
        
        if failed == true
          @html += "<tr><th colspan=\"15\">*** FAILURE on page #{current_page}! ***</th></tr>\n"
        end
      #end while current_rows >= per_page
      end while current_page < 20
      
      @html += "</table>\n"
    end
      
    if saint_table.count > 0
      relations = [
        {
          "name" => "Traffic Driver Last",
          "id" => "127",
          "header" => ["Key", "Traffic Driver Type", "Traffic Driver Search Engine", "Traffic Driver Search Top Level Domain", "Traffic Driver Name", "Traffic Driver Search Engine Country", "Traffic Driver Search Keyword-Brand/Non-Brand", "Traffic Driver Search Keyword-Cloud", "Traffic Driver Display Ad Country", "Traffic Driver Display Ad Publisher", "Traffic Driver Display Ad Product", "Traffic Driver Display Ad Year/Quarter", "Traffic Driver 62 Org Campaign ID", "Traffic Driver 62 Org Campaign ID^Traffic Driver 62 Org Campaign Name"]
        },
        {
          "name" => "Traffic Driver First",
          "id" => "53",
          "header" => ["Key", "Traffic Driver Original-Type", "Traffic Driver Original-Search Engine", "Traffic Driver Original-Search Top Level Domain", "Traffic Driver Original-Driver Name", "Traffic Driver Original-Search Engine Country", "Traffic Driver Original-Search Keyword Brand/Non-Brand", "Traffic Driver Original-Search Keyword-Cloud", "Traffic Driver Original-Display Ad Country", "Traffic Driver Original-Display Ad Publisher", "Traffic Driver Original-Display Ad Product", "Traffic Driver Original-Display Ad Year/Quarter", "Traffic Driver Original-62 Org Campaign ID", "Traffic Driver Original-62 Org Campaign ID^Traffic Driver Original-62 Org Campaign Name"]
        }
      ];
      
      relations.each do |variable|
        create_response = @client.request "Saint.ImportCreateJob", {
          "check_divisions" => "0",
          "description" => "SAINT API script",
          "email_address" => user.email,
          "export_results" => "0",
          "header" => variable["header"],
          "overwrite_conflicts" => "1",
          "relation_id" => variable["id"],
          "report_suite_array" => suites
        }
        
        failed = false
        if !create_response.nil?
          populate_response = @client.request "Saint.ImportPopulateJob", {
            "job_id" => create_response,
            "page" => "1",
            "rows" => saint_table
          }
          
          if !populate_response.nil? && populate_response.to_s.downcase != "failed"
            commit_response = @client.request "Saint.ImportCommitJob", {
              "job_id" => create_response
            }
            
            if !commit_response.nil? && commit_response.to_s.downcase != "failed"
              job_id = create_response.gsub("\"", "")
              @msg += "- Site: #{site.name} / Variable: #{variable["name"]} / Rows: #{saint_table.count} / Job ID: #{job_id}\r\n"
              @html += "<p>Site: #{site.name} / Variable: #{variable["name"]} / Rows: #{saint_table.count} / Job ID: #{job_id}</p>\n"
            else
              failed = true
            end
          else
            failed = true
          end
        else
          failed = true
        end
        
        if failed
          @msg += "- Site: #{site.name} / Variable: #{variable["name"]} / Rows: 0 (due to error)\r\n"
          @html += "<p>Site: #{site.name} / Variable: #{variable["name"]} / Rows: 0 (due to error)</p>\n"
        end
      end
    end
    
    # send notification email
    Rails.logger.debug @msg
    SaintMailer.job_email(@msg, user, failed).deliver
        
    @html
  end
  
  def get_params(suite, els)
    d_end = Date.new(Time.now.year, Time.now.month, Time.now.day)
    d_start = d_end - 30
    params = {
      "reportDescription" => {
        "reportSuiteID" => suite,
        "dateFrom" => d_start.strftime("%Y-%m-%d"),
        "dateTo" => d_end.strftime("%Y-%m-%d"),
        "metrics" => [
          {"id" => "event11"}
        ],
        "elements" => els
      }
    }
    params
  end
end