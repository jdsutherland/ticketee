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

  context "permissions" do
    subject { ProjectPolicy.new(user, project) }

    let(:user) { create(:user) }
    let(:project) { create(:project) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show }
      it { should permit_action :update }
    end

    context "for managers of other projects" do
      before do
        assign_role!(user, :manager, create(:project))
      end

      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end

    context "for administrators" do
      let(:user) { create :user, :admin }

      it { should permit_action :show }
      it do
        should permit_action :update
      end
    end
  end
end
