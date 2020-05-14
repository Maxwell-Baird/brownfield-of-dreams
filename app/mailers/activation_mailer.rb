class ActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: @user.email, subject: 'Confirming your registration.')
  end
end
