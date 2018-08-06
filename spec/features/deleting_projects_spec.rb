require 'rails_helper'

feature "Users can delete a project" do
  scenario 'with valid attributes' do
    FactoryGirl.create(:project, name: 'vim')

    visit '/'
    click_link 'vim'
    click_link 'Delete Project'

    expect(page).to have_content "Project has been deleted."
    expect(page.current_url).to eq projects_url
    expect(page).to have_no_content "vim"
  end
end
