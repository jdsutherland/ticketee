require 'rails_helper'

describe ProjectPolicy do
  permissions :show? do
    it 'blocks anonymous users' do
      user = create(:user)
      project = create(:project, name: 'vim')

      expect(ProjectPolicy).not_to permit(user, project)
    end

    it 'allows viewers of the project' do
      user = create(:user)
      project = create(:project, name: 'vim')
      assign_role!(user, :viewer, project)

      expect(ProjectPolicy).to permit(user, project)
    end

    it 'allows editors of the project' do
      user = create(:user)
      project = create(:project, name: 'vim')
      assign_role!(user, :editor, project)

      expect(ProjectPolicy).to permit(user, project)
    end

    it 'allows managers of the project' do
      user = create(:user)
      project = create(:project, name: 'vim')
      assign_role!(user, :manager, project)

      expect(ProjectPolicy).to permit(user, project)
    end

    it 'allows administrators' do
      admin = create(:user, :admin)
      project = create(:project, name: 'vim')

      expect(ProjectPolicy).to permit(admin, project)
    end

    it "doesn't allow viewers assigned to different projects" do
      user = create(:user)
      project = create(:project, name: 'vim')
      other_project = create(:project, name: 'vim')
      assign_role!(user, :manager, project)

      expect(ProjectPolicy).not_to permit(user, other_project)
    end
  end
end
