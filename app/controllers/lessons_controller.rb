# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy remove_video remove_video_thumbnail]
  before_action :set_course

  # GET /lessons or /lessons.json
  def index
    @lessons = @course.lessons.rank(:row_order)
  end

  # GET /lessons/1 or /lessons/1.json
  def show
    authorize @lesson
    current_user.view_lesson(@lesson)
    @lessons = @course.lessons.rank(:row_order)
    @comments = @lesson.comments.includes(:user)
    @comment = Comment.new(user: current_user, lesson: @lesson)
  end

  # GET /lessons/new
  def new
    @lesson = @course.lessons.new
    authorize @lesson
  end

  # GET /lessons/1/edit
  def edit
    authorize @lesson
  end

  # POST /lessons or /lessons.json
  def create
    authorize @course
    @lesson = @course.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    authorize @lesson
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    authorize @lesson
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to course_lessons_url(@course), notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sort
    @course = Course.friendly.find(params[:course_id])
    lesson = Lesson.friendly.find(params[:lesson_id])
    authorize lesson, :edit?
    lesson.update(lesson_params)
    render body: nil
  end

  def remove_video
    authorize @lesson, :edit?
    @lesson.video.purge
    redirect_to edit_course_lesson_path(@course, @lesson), notice: 'Video was successfully removed.'
  end

  def remove_video_thumbnail
    authorize @lesson, :edit?
    @lesson.video_thumbnail.purge
    redirect_to edit_course_lesson_path(@course, @lesson), notice: 'Video thumbnail was successfully removed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = Lesson.friendly.find(params[:id])
  end

  def set_course
    @course = Course.friendly.find(params[:course_id])
  end

  # Only allow a list of trusted parameters through.
  def lesson_params
    params.require(:lesson).permit(:title, :content, :row_order_position, :video_url, :video, :video_thumbnail)
  end
end
