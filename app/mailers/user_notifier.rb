class UserNotifier < ActionMailer::Base
  layout 'email'

  default from: ENV['EMAIL_FROM'] || 'noreply@scrubpay.com'

  helper_method :web_url

  def reset_password_email(user)
    @user = user
    @password_reset_url = "#{web_url}/password_resets/#{@user.reset_password_token}/edit"
    mail(:to => user.email, :subject => I18n.t('email.users.reset_password.subject'))
  end

  private

  def web_url
    @web_url ||= ENV['WEB_URL'] || 'http://locahost:9000'
  end
end
