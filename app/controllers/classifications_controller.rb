class ClassificationsController < ApplicationController
  def index
  end
  
  def run
    @html = ""
    
    if !params[:id].nil?
      sites = Site.find_all_by_id(params[:id])
    else
      sites = Site.all
    end
    
    sites.each do |s|
      if Rails.env.production?
        flash[:success] = "Your job was queued. You will receive an email when your request is completed and the SAINT rows have been submitted to Omniture."
        s.delay.run_classifications
      else
        @html += s.run_classifications  
      end
    end
  end
end