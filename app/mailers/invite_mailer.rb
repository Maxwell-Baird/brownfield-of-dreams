class InviteMailer < ApplicationMailer
  def invite(info, email)
    @user = info[:user]
    @invitee = info[:invitee]
    mail(to: email, subject: "#{@user} is sending you an invite")
  end
end
