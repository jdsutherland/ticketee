require 'rails_helper'

feature "Users can create new tickets" do
  scenario "with valid attributes" do
    project = FactoryGirl.create(:project, name: "Internet Explorer")

    visit project_path(project)
    click_link 'New Ticket'
    fill_in 'Name', with: 'Non-standards compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'

    expect(page).to have_content "Ticket has been successfully created."
  end

  scenario 'when providing invalid attributes' do
    project = FactoryGirl.create(:project, name: "Internet Explorer")

    visit project_path(project)
    click_link 'New Ticket'
    click_button 'Create Ticket'

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'with an invalid description' do
    project = FactoryGirl.create(:project, name: "Internet Explorer")

    visit project_path(project)
    click_link 'New Ticket'
    fill_in 'Name', with: 'Non-standards compliance'
    fill_in 'Description', with: 'It sucks'
    click_button 'Create Ticket'

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end
end

