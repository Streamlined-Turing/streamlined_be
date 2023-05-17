class UserMailer < ApplicationMailer
  default from: 'welcome@example.com'
  
  def welcome_email
    @email = params[:email]
    @name = params[:name]
    @url = 'https://stream-lined.herokuapp.com/'
    mail(to: @email, subject: 'Welcome to StreamLined')
  end
end
