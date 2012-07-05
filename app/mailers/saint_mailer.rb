class SaintMailer < ActionMailer::Base
  default from: "no-reply@salesforcewebanalytics.herokuapp.com"
 
  def job_email(msg, user)
    @msg = msg
    mail(:to => user.email, :subject => "SAINT rows queued for Salesforce.com sites")
  end
end