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

  private

  def project_editor_created_ticket?
    record.project.has_editor?(user) && record.author == user
  end
end

