require 'rails_helper'

feature "Users can view a tickets attached files" do
  scenario "successfully" do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :viewer, project)
    ticket = create(:ticket, project: project, author: author)
    attachment = create(:attachment, ticket: ticket, file_to_attach: "spec/fixtures/speed.txt")

    visit project_ticket_path(project, ticket)
    click_link 'speed.txt'

    expect(current_path).to eq attachment_path(attachment)
    expect(page).to have_content 'The blink tag can blink faster'
  end
end
