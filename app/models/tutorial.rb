class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial,
                                                  dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates :title, :description, :thumbnail, presence: true

  def fill_playlist(playlist_id)
    youtube = YoutubeService.new
    video_list = youtube.playlist(playlist_id)
    video_list.each do |video|
      videos.create(new_video_params(video))
    end
  end

  private

  def new_video_params(vid)
    { title: vid[:snippet][:title],
      description: vid[:snippet][:description],
      video_id: vid[:snippet][:resourceId][:videoId],
      thumbnail: vid[:snippet][:thumbnails][:high][:url],
      position: vid[:snippet][:position] }
  end
end
