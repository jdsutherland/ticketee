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

  scenario "when changing a ticket's state" do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    ticket = create(:ticket, project: project, author: author)
    create(:state, name: 'Open')

    visit project_ticket_path(project, ticket)
    fill_in 'Text', with: 'This is a real issue!'
    select 'Open', from: 'State'
    click_button 'Create Comment'

    expect(page).to have_content "Comment has been created."
    within('#ticket .state') do
      expect(page).to have_content "Open"
    end
    within('#comments') do
      expect(page).to have_content "state changed to Open"
    end
  end

  scenario "but cannot change the state without permission" do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :editor, project)
    ticket = create(:ticket, project: project, author: author)

    visit project_ticket_path(project, ticket)

    expect(page).not_to have_select 'State'
  end

  scenario "when adding a new tag to a ticket" do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    ticket = create(:ticket, project: project, author: author)

    visit project_ticket_path(project, ticket)
    expect(page).not_to have_content "bug"
    fill_in 'Text', with: 'Adding the bug tag'
    fill_in 'Tags', with: 'bug'
    click_button 'Create Comment'

    expect(page).to have_content "Comment has been created."
    within('#ticket #tags') do
      expect(page).to have_content "bug"
    end
  end
end
