class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #Restaurant.all
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

private

 def user_is_owner_or_admin?
   user == record.user || user.admin
 end

end
