class ActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    @user_first_name = user.first_name
    @user_last_name = user.last_name
    mail(to: @user.email, subject: 'Confirming your registration.')
  end
end
