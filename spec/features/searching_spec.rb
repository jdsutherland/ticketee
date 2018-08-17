require 'rails_helper'

feature "Users can search for tags matching specific criteria" do
  scenario 'searching by tag' do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    ticket_1 = create(:ticket, name: 'Create doodad',
                      project: project, author: author,
                             tag_names: 'iteration_1')
    ticket_2 = create(:ticket, name: 'Create ramrod',
                      project: project, author: author,
                      tag_names: 'iteration_2')

    visit project_path(project)
    fill_in 'Search', with: 'tag:iteration_1'
    click_button 'Search'

    within('#tickets') do
      expect(page).to have_link 'Create doodad'
      expect(page).not_to have_link 'Create ramrod'
    end
  end
end

