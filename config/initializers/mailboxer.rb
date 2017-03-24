Mailboxer.setup do |config|

  #Configures if you application uses or not email sending for Notifications and Messages
  config.uses_emails = true
 
  #Configures the default from for emails sent for Messages and Notifications
  config.default_from = "no-reply@mailboxer.com"
 
  #Configures the methods needed by mailboxer
  config.email_method = :mailboxer_email
  config.name_method = :name
end
