class CommentsController < ApplicationController
  before_action :set_course, only: :create
  before_action :set_lesson, only: :create

  def create
    @comment = @lesson.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to course_lesson_path(@course, @lesson), notice: 'Comment has successfully been created.'
    else
      redirect_to course_lesson_path(@course, @lesson), alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def set_course
    @course = Course.friendly.find(params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.friendly.find(params[:lesson_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
