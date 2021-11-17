class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @tags = Tag.joins(:courses)
    .where.not(course_tags_count: 0)
    .where(courses: { workflow_state: :published })
    .order(course_tags_count: :desc)
  end

  def create
    tag = Tag.new(permitted_params)

    if tag.save
      render json: tag
    else
      render json: { errors: tag.errors.full_messages }
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize @tag
    @tag.destroy!
    redirect_to tags_path, notice: 'Tag was successfully destroyed.'
  end

  private

  def permitted_params
    params.require(:tag).permit(:name)
  end
end
