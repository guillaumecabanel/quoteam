class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user
  end

  def show?
  end

  def new?
    create?
  end

  def create?
    user
  end

end
