require 'rails_helper'

feature "Admins can create new users" do
  scenario "with valid credentials" do
    login_as(FactoryGirl.create(:user, :admin))
    visit "/"

    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
    fill_in 'Email', with: 'newbie@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create User'

    expect(page).to have_content "User has been created."
  end
end

