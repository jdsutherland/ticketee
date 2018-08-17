require 'rails_helper'

feature "Users can delete unwanted tags from a ticket" do
  scenario 'successfully', js: true do
    author = create(:user)
    login_as(author)
    project = create(:project)
    assign_role!(author, :manager, project)
    ticket = create(:ticket, project: project, author: author,
                             tag_names: 'ThisTagMustDie')

    visit project_ticket_path(project, ticket)
    within tag('ThisTagMustDie') do
      click_link 'remove'
    end

    expect(page).not_to have_content "ThisTagMustDie"
  end
end
