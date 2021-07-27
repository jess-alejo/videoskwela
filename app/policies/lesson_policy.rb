class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @user.has_role?(:admin) || @record.course.author == @user
  end

  def create?
    @record.course.author == @user
  end

  def update?
    @record.course.author == @user
  end

  def destroy?
    @record.course.author == @user
  end
end
