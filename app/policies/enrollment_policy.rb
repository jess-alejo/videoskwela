class EnrollmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.has_role? :admin
  end

  def update?
    @record.student_id == @user.id
  end

  def destroy?
    @user.has_role? :admin
  end

  def certificate?
    @record.course.completed? @record.student
  end
end
