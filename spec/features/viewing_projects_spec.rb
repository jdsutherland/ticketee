require 'rails_helper'

feature "Users can view projects" do
  scenario 'with the project details' do
    user = create(:user)
    project = create(:project, name: 'vim')
    login_as(user)
    assign_role!(user, :viewer, project)

    visit '/'
    click_link 'vim'

    expect(page.current_url).to eq project_url(project)
  end
end
