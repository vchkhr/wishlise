class ListPolicy < ApplicationPolicy
  def index?
    user == record.user
  end

  def show?
    user == record.user || record.by_link? || record.public?
  end

  def create?
    true
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end
