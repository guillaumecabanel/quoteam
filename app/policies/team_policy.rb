class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user
        scope.all
      end
    end
  end

  def show?
    user
  end
end
