class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user.id == record.id
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || (user.role == 'user' && user.id == record.id)
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    [:name, :email, :password, :role, :admin]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
