# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Saint::Application.initialize!

Saint::Application.configure do
  config.omni_username	= 'jwest:Salesforce'
  config.omni_secret	= 'd1c4e1ab8a79f1c9699d2f187c1d731a'
end