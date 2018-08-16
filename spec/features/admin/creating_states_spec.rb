require 'rails_helper'

feature "Admins can create new states for tickets" do
  scenario "with valid details" do
    login_as(create(:user, :admin))

    visit admin_root_path
    click_link 'States'
    click_link 'New State'
    fill_in 'Name', with: "Won't fix"
    fill_in 'Color', with: 'orange'
    click_button 'Create State'

    expect(page).to have_content "State has been created."
  end
end

