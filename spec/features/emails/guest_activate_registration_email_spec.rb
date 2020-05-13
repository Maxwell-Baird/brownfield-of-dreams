require 'rails_helper'

RSpec.describe "As a guest User", type: :feature do
  it "I click link to fill in form to register with inactive status" do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click 'Register'

    expect(current_path).to eq('/register')

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as Jim Bob")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
    expect(page).to have_content("Status: Inactive")
  end
end