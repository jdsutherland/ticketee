require 'rails_helper'

feature "Users can create new projects" do
  scenario "with valid attributes" do
    visit "/"

    click_link 'New Project'
    fill_in 'Name', with: 'vim'
    fill_in 'Description', with: 'donate to Uganda'
    click_button 'Create Project'

    expect(page).to have_content "Project has been successfully created."
  end
end
