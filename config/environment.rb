# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Saint::Application.initialize!

Saint::Application.configure do
  config.omni_username	= 'jwest:Salesforce'
  config.omni_secret	= '226abdf79ac59c15faad318b33a68063'
end

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "app4759519@heroku.com",
  :password => "adcoqqhk",
  :domain => "salesforcewebanalytics.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}