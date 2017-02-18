class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    @record.enrollments.find_by_user_id(user)
  end
end
