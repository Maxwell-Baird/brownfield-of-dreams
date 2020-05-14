
require 'rails_helper'

describe "An Admin can edit a tutorial" do
  let(:admin)    { create(:admin) }

  scenario "by adding a video", :js => true do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    prework_tutorial_data = {
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>false,
    }
    prework_tutorial = Tutorial.create! prework_tutorial_data

    video1 = prework_tutorial.videos.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "position"=>1
    })
    video2 = prework_tutorial.videos.create!({
      "title"=>"Prework - SSH Key Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"XsPVWGKK0qI",
      "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
      "position"=>2
    })
    video3 = prework_tutorial.videos.create!({
      "title"=>"Prework - Strings",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"iXLwXvev4X8",
      "thumbnail"=>"https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg",
      "position"=>3
    })

    visit edit_admin_tutorial_path(prework_tutorial)
    expect(prework_tutorial.videos[0][:title]).to eq("Prework - Environment Setup")
    expect(prework_tutorial.videos[1][:title]).to eq("Prework - SSH Key Setup")

    within("#video-list") do
      source = page.find("img[src*='https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg']")
      target = page.find("img[src*='https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg']")
      source.drag_to(target)
    end
    click_on('Save Video Order')
    visit '/'

    click_on prework_tutorial.title

    expect(current_path).to eq(tutorial_path(prework_tutorial))
    expect(page).to have_content(video2.title)  
    expect(page).to have_content(prework_tutorial.title)
  end
end
