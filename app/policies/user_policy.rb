class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user
        scope.find_by_id(user)
      else
        false
      end
    end
  end

  def enroll?
    user
  end

end
