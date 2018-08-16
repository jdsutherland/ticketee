require 'rails_helper'

feature "Users can comment on tickets" do
  scenario "with valid attributes" do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    ticket = create(:ticket, project: project, author: author)

    visit project_ticket_path(project, ticket)
    fill_in 'Text', with: 'Added a comment!'
    click_button 'Create Comment'

    expect(page).to have_content "Comment has been created."
    within('#comments') do
      expect(page).to have_content "Added a comment!"
    end
  end

  scenario "with invalid attributes" do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    ticket = create(:ticket, project: project, author: author)

    visit project_ticket_path(project, ticket)
    click_button 'Create Comment'

    expect(page).to have_content "Comment has not been created."
  end
end
