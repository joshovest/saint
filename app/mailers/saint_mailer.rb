class SaintMailer < ActionMailer::Base
  default from: "no-reply@salesforcewebanalytics.herokuapp.com"
 
  def job_email(msg, user, failed)
    @msg = msg
    @headline = ""
    if failed
      subject = "SAINT scheduler failed"
      @headline = "The SAINT scheduler encountered a problem while running:"
    else
      subject = "SAINT scheduler ran successfully"
      @headline = "The following traffic driver classifications have been submitted to Omniture:"
    end
    mail(:to => user.email, :subject => subject)
  end
end