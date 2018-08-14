require 'rails_helper'

describe ProjectPolicy do
  context "policy_scope" do
    it "is empty for anonymous users" do
      expect(Pundit.policy_scope(nil, Project)).to be_empty
    end

    it "includes projects a user is allowed to view" do
      user = create(:user)
      project = create(:project)
      assign_role!(user, :viewer, project)

      expect(Pundit.policy_scope(user, Project)).to include(project)
    end

    it "doesn't include a projects it isn't allowed to view" do
      user = create(:user)

      expect(Pundit.policy_scope(user, Project)).to be_empty
    end

    it "returns all projects for admins" do
      user = create(:user)
      project = create(:project)
      user.admin = true

      expect(Pundit.policy_scope(user, Project)).to include(project)
    end
  end

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

  permissions :update? do
    it 'blocks anonymous users' do
      user = create(:user)
      project = create(:project, name: 'vim')

      expect(ProjectPolicy).not_to permit(user, project)
    end

    it "doesn't allow viewers of the project" do
      user = create(:user)
      project = create(:project, name: 'vim')
      assign_role!(user, :viewer, project)

      expect(ProjectPolicy).not_to permit(user, project)
    end

    it "doesn't allow editors of the project" do
      user = create(:user)
      project = create(:project, name: 'vim')
      assign_role!(user, :editor, project)

      expect(ProjectPolicy).not_to permit(user, project)
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

    it "doesn't allow users assigned to different projects" do
      user = create(:user)
      project = create(:project, name: 'vim')
      other_project = create(:project, name: 'vim')
      assign_role!(user, :manager, project)

      expect(ProjectPolicy).not_to permit(user, other_project)
    end
  end
end
