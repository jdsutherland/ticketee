require 'rails_helper'

feature 'Users watch and unwatch tickets' do
  scenario "successfully" do
    user = create(:user)
    project = create(:project)
    ticket = create(:ticket, project: project, author: user)
    assign_role!(user, :manager, project)
    login_as(user)

    visit project_ticket_path(project, ticket)

    within('#watchers') do
      expect(page).to have_content user.email
    end

    click_link 'Unwatch'
    expect(page).to have_content "You are no longer watching this ticket."

    within('#watchers') do
      expect(page).to_not have_content user.email
    end

    click_link 'Watch'
    expect(page).to have_content "You are now watching this ticket."

    within('#watchers') do
      expect(page).to have_content user.email
    end
  end
end

