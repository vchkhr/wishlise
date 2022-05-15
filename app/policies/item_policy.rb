class ItemPolicy < ApplicationPolicy
  def show?
    false
  end
  
  def new?
    true
  end

  def create?
    user == record.list.user
  end

  def update?
    user == record.list.user
  end

  def destroy?
    user == record.list.user
  end
end
