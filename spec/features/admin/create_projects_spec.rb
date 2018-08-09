require 'rails_helper'

feature "Users can create new projects" do
  scenario "with valid attributes" do
    login_as(create(:user, :admin))
    visit "/"

    click_link 'New Project'
    fill_in 'Name', with: 'vim'
    fill_in 'Description', with: 'donate to Uganda'
    click_button 'Create Project'

    expect(page).to have_content "Project has been successfully created."

    project = Project.find_by(name: 'vim')
    expect(page.current_url).to eq project_url(project)

    title = "vim - Projects - Ticketee"
    expect(page).to have_title title
  end

  scenario 'when providing invalid attributes' do
    login_as(create(:user, :admin))
    visit '/'

    click_link 'New Project'
    click_button 'Create Project'

    expect(page).to have_content "Project has not been created."
    expect(page).to have_content "Name can't be blank"
  end
end
