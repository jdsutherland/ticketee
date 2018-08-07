require 'rails_helper'

feature "Users can delete a ticket" do
  scenario 'with valid attributes' do
    project = FactoryGirl.create(:project)
    ticket = FactoryGirl.create(:ticket, project: project)

    visit project_ticket_path(project, ticket)
    click_link 'Delete Ticket'

    expect(page).to have_content "Ticket has been deleted."
    expect(page.current_url).to eq project_url(project)
  end
end

