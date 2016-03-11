class ApplicationMailer < ActionMailer::Base
  default from: "contact@skello.io"
  layout 'mailer'

  def welcome_mail(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: "samy.amar.paris@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
