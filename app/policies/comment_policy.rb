# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    @record.user == @user || @user.admin? || @record.lesson.course.author == @user
  end
end
