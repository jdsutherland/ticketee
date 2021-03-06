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

  scenario 'searching by state' do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    open = State.create(name: 'Open', default: true)
    closed = State.create(name: 'Closed')
    ticket_1 = create(:ticket, name: 'Create doodad', project: project,
                               author: author, tag_names: 'iteration_1',
                               state: open)
    ticket_2 = create(:ticket, name: 'Create ramrod', project: project,
                               author: author, tag_names: 'iteration_2',
                               state: closed)

    visit project_path(project)
    fill_in 'Search', with: 'state:Open'
    click_button 'Search'

    within('#tickets') do
      expect(page).to have_link 'Create doodad'
      expect(page).not_to have_link 'Create ramrod'
    end
  end

  scenario "when clicking on a tag" do
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
    click_link 'Create doodad'
    click_link 'iteration_1'

    within('#tickets') do
      expect(page).to have_link 'Create doodad'
      expect(page).not_to have_link 'Create ramrod'
    end
  end
end
