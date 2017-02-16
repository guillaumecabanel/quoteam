class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def home?
    true
  end

end
