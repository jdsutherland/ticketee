require 'rails_helper'

feature "Users can edit existing projects" do
  scenario 'with valid attributes' do
    project = FactoryGirl.create(:project, name: 'vim')

    visit '/'
    click_link 'vim'
    click_link 'Edit Project'
    fill_in 'Name', with: 'neovim'
    click_button 'Update Project'

    expect(page).to have_content "Project has been updated."
    expect(page).to have_content "neovim"
  end

  scenario 'with invalid attributes' do
    project = FactoryGirl.create(:project, name: 'vim')

    visit '/'
    click_link 'vim'
    click_link 'Edit Project'
    fill_in 'Name', with: ''
    click_button 'Update Project'

    expect(page).to have_content "Project has not been updated."
  end
end
