class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.project.has_member?(user)
  end

  def create?
    user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
  end

  def update?
    user.try(:admin?) || record.project.has_manager?(user) || project_editor_created_ticket?
  end

  def destroy?
    user.try(:admin?) || record.project.has_manager?(user)
  end

  def change_state?
    destroy?
  end

  def tag?
    destroy?
  end

  private

  def project_editor_created_ticket?
    record.project.has_editor?(user) && record.author == user
  end
end

