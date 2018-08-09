require 'rails_helper'

feature "Users can only see appropriate links" do
  context 'anonymous users' do
    scenario 'cannot see the New Project Link' do
      visit '/'

      expect(page).to_not have_link "New Project"
    end

    scenario 'cannot see the Delete Project Link' do
      project = create(:project)
      visit project_path(project)

      expect(page).to_not have_link "Delete Project"
    end
  end

  context 'regular users' do
    scenario 'cannot see the New Project Link' do
      login_as(create(:user))
      visit '/'

      expect(page).to_not have_link "New Project"
    end

    scenario 'cannot see the Delete Project Link' do
      project = create(:project)
      visit project_path(project)

      expect(page).to_not have_link "Delete Project"
    end
  end

  context 'admin users' do
    scenario 'can see the New Project Link' do
      login_as(create(:user, :admin))
      visit '/'

      expect(page).to have_link "New Project"
    end

    scenario 'can see the Delete Project Link' do
      login_as(create(:user, :admin))
      project = create(:project)
      visit project_path(project)

      expect(page).to have_link "Delete Project"
    end
  end
end


