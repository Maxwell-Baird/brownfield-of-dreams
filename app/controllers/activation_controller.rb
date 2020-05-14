class ActivationController < ApplicationController
  def update
    user = User.find(params[:user_id])
    user.update(status: 'Active')

    redirect_to '/activated'
  end

  def show; end
end
