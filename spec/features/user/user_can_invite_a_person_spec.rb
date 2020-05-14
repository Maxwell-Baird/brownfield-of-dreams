require 'rails_helper'

describe 'User' do
  it 'user gets an error when github does not have user', :vcr do
    user = User.create(email: 'user@email.com',
      password: 'password',
      first_name: 'Jim',
      last_name: 'BIlly',
      username: 'JimBill',
      role: 0,
      token: "#{ENV['GITHUB_TOKEN']}")

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_link("Send an invite")
    click_on("Send an invite")

    click_on"Send Invite"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user does not exist.")
  end

  it 'user gets an error when github does not have user email', :vcr do
    user = User.create(email: 'user@email.com',
      password: 'password',
      first_name: 'Jim',
      last_name: 'BIlly',
      username: 'JimBill',
      role: 0,
      token: "#{ENV['GITHUB_TOKEN']}")

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_link("Send an invite")
    click_on("Send an invite")
    fill_in "username", with: 'DavidTTran'

    click_on"Send Invite"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected does not have an email address associated with their account.")
  end

  it 'user gets a sucess message', :vcr do
    user = User.create(email: 'user@email.com',
      password: 'password',
      first_name: 'Jim',
      last_name: 'BIlly',
      username: 'JimBill',
      role: 0,
      token: "#{ENV['GITHUB_TOKEN']}")

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_link("Send an invite")
    click_on("Send an invite")
    fill_in "username", with: 'Maxwell-Baird'

    click_on"Send Invite"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully sent invite!")
  end

end
