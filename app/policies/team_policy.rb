class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user
        scope.find_by_id(user.team.id)
      else
        false
      end
    end
  end

end
