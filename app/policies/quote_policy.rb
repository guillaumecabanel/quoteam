class QuotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
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

  def update?
    destroy?
  end

  def destroy?
    ( user && user.admin? ) || @record.user == user
  end

  def like?
    user
  end
end
