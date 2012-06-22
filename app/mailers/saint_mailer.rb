class SaintMailer < ActionMailer::Base
  default from: "josh.west@salesforce.com"
 
  def job_email(msg, user)
    @msg = msg
    mail(:to => user.email, :subject => "SAINT rows queued for Salesforce.com sites")
  end
end