class TagsController < ApplicationController
  def create
    tag = Tag.new(permitted_params)

    if tag.save
      render json: tag
    else
      render json: { errors: tag.errors.full_messages }
    end
  end

  private

  def permitted_params
    params.require(:tag).permit(:name)
  end
end
