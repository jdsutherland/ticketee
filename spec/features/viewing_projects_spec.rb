require 'rails_helper'

feature "Users can view projects" do
  scenario 'with the project details' do
    project = FactoryGirl.create(:project, name: 'vim')

    visit '/'
    click_link 'vim'

    expect(page.current_url).to eq project_url(project)
  end
end
