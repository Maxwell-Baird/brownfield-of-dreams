class InviteController < ApplicationController
  def show; end

  def create
    if current_user.git_user_exist(params[:username])
      email = current_user.git_email(params[:username])
      if !email.nil?
        email_info = { user: current_user.username,
                       invitee: params[:username] }
        InviteMailer.invite(email_info, email).deliver_now
        flash[:notice] = 'Successfully sent invite!'
      else
        flash[:error] = 'The Github user you selected does not have an email
        address associated with their account.'
      end
    else
      flash[:error] = 'The Github user does not exist.'
    end
    redirect_to dashboard_path
  end
end
