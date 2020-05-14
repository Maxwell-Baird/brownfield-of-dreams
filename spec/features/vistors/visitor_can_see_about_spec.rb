require 'rails_helper'

describe 'Visitor' do
    it 'can see the get started' do
    visit '/about'

    message = "Sign In Register\nTuring Tutorials\nThis application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students."

    expect(page).to have_content(message)
  end
end
