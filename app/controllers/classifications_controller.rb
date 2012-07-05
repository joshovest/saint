class ClassificationsController < ApplicationController
  def index
    @msg = "Test email"
    u = User.first
    SaintMailer.job_email(@msg, u).deliver
  end
  
  def queue
    require 'omni'
    
    @html = "" 
    flash[:success] = "Your job was queued. You will receive an email when your request is completed and the SAINT rows have been submitted to Omniture."
    
    sites = Site.all
    sites.each do |s|
      s.delay.run_classifications
    end
  end
  
  def run
    require 'omni'
    
    @html = ""
    sites = Site.all
    sites.each do |s|
      @html += s.run_classifications
    end
  end
end
