class ProfilePolicy < ApplicationPolicy
  def show?
    user == record.user || record.public?
  end

  def create?
    user.profile.nil?
  end

  def update?
    user == record.user
  end
end
