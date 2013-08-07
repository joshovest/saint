class DashboardVideoNamesController < ApplicationController
  def video_starts
    load if !is_current_data?
    
    @dashboard_video_names = DashboardVideoName.find(:all, :order => "start_date DESC, video_starts DESC")
    
    respond_to do |format|
      format.html { }
      format.json {
        render :json => @dashboard_video_names
      }
    end
  end
  
  def video_completes
    load if !is_current_data?
    
    @dashboard_video_names = DashboardVideoName.find(:all, :order => "start_date DESC, video_completes DESC")
    
    respond_to do |format|
      format.html { }
      format.json {
        render :json => @dashboard_video_names
      }
    end
  end
  
  def is_current_data?
    if DashboardVideoName.all.length == 0
      cur = false
    elsif (DashboardVideoName.maximum(:start_date)+30) < 2.days.ago.to_date
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
        "id" => "eVar7",
        "top" => "25"
      }
    ]
    t_end = [
      Time.new.to_date - 2,
      Time.new.to_date - 32
    ]
    metrics = [
      {"id" => "event7"},
      {"id" => "event70"}
    ]
    segment = "dsc:280:228:c221f926-19c8-4430-b9b0-56d6095bd6b4"
    
    o = Omni.new
    count = 0
    t_end.each do |t|
      if Rails.env.production?
        o.delay.load_videos(suite_id, metrics, segment, elements, t - 30, t, count == 0)
      else
        o.load_videos(suite_id, metrics, segment, elements, t - 30, t, count == 0)
      end
      count += 1
    end
  end
end