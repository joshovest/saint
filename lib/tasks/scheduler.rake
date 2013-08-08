desc "This task is called by the Heroku scheduler add-on and runs the SAINT scheduler 4 times each week (M/W/T/S)."
task :schedule_saint => :environment do
  current_time = Time.new
  valid_days = [ 1, 3, 4, 6 ]
  if valid_days.include?(current_time.wday)
    sites = Site.all
    sites.each do |s|
      s.delay.run_classifications
    end
    puts current_time.strftime("Done queuing SAINT scheduler %-m/%-d/%Y.")
  end
end