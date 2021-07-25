class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    @user.has_role?(:instructor)
  end

  def update?
    @user.has_role?(:admin) || @user == @record.author
  end

  def destroy?
    @user.has_role?(:admin) || @user == @record.author
  end
end
