require 'rails_helper'

describe 'Visitor' do
    it 'can see the get started' do
      visit '/get_started'

      expect(page).to have_link('homepage')
      expect(page).to have_link('Sign in')
  end
end
