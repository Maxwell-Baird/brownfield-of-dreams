require 'rails_helper'

RSpec.describe "To register an account", type: :feature do
  it "As a guest user I fill in form to register with inactive status" do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Register'

    expect(current_path).to eq('/register')

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

  xit "As a non-activated user I click link in my email to activate" do
    visit '/'

    expect(page).to have_content("Status: Inactive")

  end
end