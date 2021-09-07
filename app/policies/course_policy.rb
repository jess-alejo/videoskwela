class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show
    @record.published? || @user.admin? || @record.author == @user || @user.enrolled?(@record)
  end

  def create?
    @user&.has_role?(:instructor)
  end

  def update?
    @user&.has_role?(:admin) || @user == @record.author
  end

  def destroy?
    @record.author == @user && @record.enrollments.blank?
  end

  def author?
    @user == @record.author
  end

  def publish?
    author?
  end

  def review?
    @user&.has_role?(:admin)
  end

  def approve?
    @user&.has_role?(:admin)
  end
end
