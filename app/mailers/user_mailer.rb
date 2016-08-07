class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.commit_alert.subject
  #
  def commit_alert(user)
    @user = user

    mail to: user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.weekly_update.subject
  #
  def weekly_update(user)
    @user = user

    mail to: user.email
  end
end
