class QuotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user
  end

  def create?
    user
  end

  def update?
    user
  end

  def destroy?
    ( user && user.admin? ) || @record.user == user
  end

  def upvote?
    user
  end
end
