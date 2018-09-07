require 'rails_helper'

feature 'Users can receive notifications about ticket updates' do
  scenario "ticket authors automatically receive notifications" do
    alice = create(:user, email: 'alice@example.com')
    bob = create(:user, email: 'bob@example.com')
    project = create(:project)
    ticket = create(:ticket, project: project, author: alice)
    assign_role!(alice, :manager, project)
    assign_role!(bob, :manager, project)
    login_as(bob)

    visit project_ticket_path(project, ticket)
    fill_in 'Text', with: 'Is it out yet?'
    click_button 'Create Comment'

    email = find_email!(alice.email)
    expected_subject = "[ticketee] #{project.name} - #{ticket.name}"
    expect(email.subject).to eq expected_subject
    click_first_link_in_email(email)
    expect(current_path).to eq project_ticket_path(project, ticket)
  end
end
