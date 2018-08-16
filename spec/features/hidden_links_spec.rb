require 'rails_helper'

feature "Users can only see appropriate links" do
  context 'regular users' do
    scenario 'cannot see the New Project link' do
      login_as(create(:user))
      visit '/'

      expect(page).to_not have_link "New Project"
    end

    scenario 'cannot see the Delete Project link' do
      user = create(:user)
      project = create(:project)
      login_as(user)
      assign_role!(user, :viewer, project)

      visit project_path(project)

      expect(page).to_not have_link "Delete Project"
    end
  end

  context "non-admin users (project viewers)" do
    scenario 'cannot see the Edit Project link' do
      user = create(:user)
      project = create(:project)
      login_as(user)
      assign_role!(user, :viewer, project)

      visit project_path(project)

      expect(page).to_not have_link "Edit Project"
    end

    scenario 'cannot see the New Ticket link' do
      user = create(:user)
      project = create(:project)
      login_as(user)
      assign_role!(user, :viewer, project)

      visit project_path(project)

      expect(page).to_not have_link "New Ticket"
    end

    scenario 'cannot see the Edit Ticket link' do
      user = create(:user)
      login_as(user)
      project = create(:project)
      ticket = create(:ticket, project: project, author: user)
      assign_role!(user, :viewer, project)

      visit project_ticket_path(project, ticket)

      expect(page).to_not have_link "Edit Ticket"
    end

    scenario 'cannot see the Delete Ticket link' do
      user = create(:user)
      login_as(user)
      project = create(:project)
      ticket = create(:ticket, project: project, author: user)
      assign_role!(user, :viewer, project)

      visit project_ticket_path(project, ticket)

      expect(page).to_not have_link "Delete Ticket"
    end

    scenario "cannot see the New Comment form" do
      user = create(:user)
      login_as(user)
      project = create(:project)
      ticket = create(:ticket, project: project, author: user)
      assign_role!(user, :viewer, project)

      visit project_ticket_path(project, ticket)

      expect(page).to_not have_heading "New Comment"
    end
  end

  context 'admin users' do
    scenario 'can see the New Project link' do
      login_as(create(:user, :admin))
      visit '/'

      expect(page).to have_link "New Project"
    end

    scenario 'can see the New Ticket link' do
      login_as(create(:user, :admin))
      project = create(:project)

      visit project_path(project)

      expect(page).to have_link "New Ticket"
    end

    scenario 'can see the Edit Ticket link' do
      user = create(:user, :admin)
      login_as(user)
      project = create(:project)
      ticket = create(:ticket, project: project, author: user)
      assign_role!(user, :viewer, project)

      visit project_ticket_path(project, ticket)

      expect(page).to have_link "Edit Ticket"
    end

    scenario 'can see the Delete Ticket link' do
      user = create(:user, :admin)
      login_as(user)
      project = create(:project)
      ticket = create(:ticket, project: project, author: user)
      assign_role!(user, :viewer, project)

      visit project_ticket_path(project, ticket)

      expect(page).to have_link "Delete Ticket"
    end

    scenario 'can see the Edit Project link' do
      login_as(create(:user, :admin))
      project = create(:project)

      visit project_path(project)

      expect(page).to have_link "Edit Project"
    end

    scenario 'can see the Delete Project link' do
      login_as(create(:user, :admin))
      project = create(:project)
      visit project_path(project)

      expect(page).to have_link "Delete Project"
    end

    scenario "can see the New Comment form" do
      user = create(:user)
      login_as(create(:user, :admin))
      project = create(:project)
      ticket = create(:ticket, project: project, author: user)

      visit project_ticket_path(project, ticket)

      expect(page).to have_heading "New Comment"
    end
  end
end


