class Admin::ImportTutorialController < Admin::BaseController
  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.create(tutorial_params)

    if @tutorial.save
      @tutorial.fill_playlist(params[:tutorial][:playlist_id])

      flash[:success] = 'Successfully created tutorial. '\
      "#{view_context.link_to('View it here', tutorial_path(@tutorial))}."
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
    end
    redirect_to '/admin/dashboard'
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:playlist_id,
                                     :title,
                                     :description,
                                     :thumbnail)
  end
end
