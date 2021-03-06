require 'rails_helper'

feature "Users can edit existing tickets" do
  scenario 'with valid attributes' do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :editor, project)
    ticket = create(:ticket, project: project, author: author)


    visit project_ticket_path(project, ticket)
    click_link 'Edit Ticket'
    fill_in 'Name', with: 'Make it really shiny!'
    click_button 'Update Ticket'

    expect(page).to have_content "Ticket has been updated."
    within('#ticket h2') do
      expect(page).to have_content "Make it really shiny!"
      expect(page).to_not have_content ticket.name
    end
  end

  scenario 'with invalid attributes' do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :editor, project)
    ticket = create(:ticket, project: project, author: author)

    visit project_ticket_path(project, ticket)
    click_link 'Edit Ticket'
    fill_in 'Name', with: ''
    click_button 'Update Ticket'

    expect(page).to have_content "Ticket has not been updated."
  end
end

