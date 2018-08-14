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
  end
end


