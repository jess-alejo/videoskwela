class CommentsController < ApplicationController
  before_action :set_course, only: %i[create destroy]
  before_action :set_lesson, only: %i[create destroy]

  def create
    @comment = @lesson.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      dom_id = 'comment_' + @comment.id.to_s
      redirect_to course_lesson_path(@course, @lesson, anchor: dom_id),
                  notice: 'Comment has successfully been created.'
    else
      redirect_to course_lesson_path(@course, @lesson), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    comment = Comment.find(params[:id])

    comment.destroy
    redirect_to course_lesson_path(@course, @lesson), notice: 'Comment has successfully been destroyed.'
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
