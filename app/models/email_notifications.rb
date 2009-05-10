class EmailNotifications < ActionMailer::Base
  

  def signup(user_email, sent_at = Time.now)
    subject    'EmailNotifications#signup'
    recipients user_email
    from       Agent.find_by_role("admin").email
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
