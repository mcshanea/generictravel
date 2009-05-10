class MailMe < ActionMailer::Base

  def reminder(user, password, sent_at = Time.now)
    subject    'Agent Password Reset'
    recipients user
    from       'alanaka.calendar@gmail.com'
    sent_on    sent_at
    
    body       :greeting => 'Hi, Your new password is '+password
  end  

  def company_created(company_name, sent_at = Time.now)
    subject    'Company Requesting Authorisation'
    recipients 'mcshaneadrian@gmail.com'
    from       'alanaka@gmail.com'
    sent_on    sent_at
    
    body       :greeting => 'Hi, ' + company_name + ' is awaiting authorisation.'
  end

  def signup(agent_email, admin_email, sent_at = Time.now)
    subject    'Agent Requesting Authorisation'
    recipients admin_email
    from       agent_email
    sent_on    sent_at
    
    body       :greeting => 'Hi, ' + agent_email + ' is awaiting authorisation.'
  end
end
