class QuotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user
        scope.where(team: user.team)
      end
    end
  end

  def index?
    user
  end

  def show?
    user
  end

  def create?
    user
  end

  def destroy?
    user && user.admin?
  end

  def upvote?
    user
  end
end
