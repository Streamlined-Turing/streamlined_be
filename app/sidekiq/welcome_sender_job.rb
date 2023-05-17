class WelcomeSenderJob
  include Sidekiq::Job

  def perform(email, name)
    UserMailer.with(email: email, name: name).welcome_email.deliver_now
  end
end
