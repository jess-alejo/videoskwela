# frozen_string_literal: true

class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_course, only: %i[show edit update destroy publish review approve analytics]
  before_action :set_tags

  # GET /courses or /courses.json
  def index
    @ransack_path = courses_path
    courses = Course.includes([image_attachment: :blob])
    @ransack_courses = courses.published.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:author))
  end

  def enrolled
    @ransack_path = enrolled_courses_path
    courses = Course.joins(:enrollments).where(enrollments: { student: current_user })
    @ransack_courses = courses.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:author))
  end

  def pending_review
    @ransack_path = pending_review_courses_path
    courses = Course.joins(:enrollments).merge(Enrollment.pending_review).where(enrollments: { student: current_user })
    @ransack_courses = courses.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:author))
    render :index
  end

  def authored
    @ransack_path = authored_courses_path
    courses = Course.where(author: current_user)
    @ransack_courses = courses.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:author))
    render :index
  end

  def pending_approval
    authorize current_user, :approve_course?
    @ransack_path = authored_courses_path
    courses = Course.pending_approval
    @ransack_courses = courses.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:author))
  end

  # GET /courses/1 or /courses/1.json
  def show
    @lessons = @course.lessons.rank(:row_order)
    @course_reviews = @course.enrollments.reviewed
    @similar_courses = @course.similar_courses
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.author = current_user
    authorize @course

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    authorize @course
    if @course.destroy
      respond_to do |format|
        format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to @course, alert: @course.errors.full_messages.to_sentence
    end
  end

  def publish
    authorize @course
    @course.publish!
    redirect_to @course, notice: "Course is now #{@course.workflow_state.titleize.downcase}."
  end

  def review
    authorize @course
    @course.review!
    redirect_to @course, notice: "Course is now #{@course.workflow_state.titleize.downcase}."
  end

  def approve
    authorize @course
    @course.approve!
    redirect_to @course, notice: "Course is now #{@course.workflow_state.titleize.downcase}."
  end

  def analytics
    authorize @course, :author?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:title, :description, :short_description, :level, :language, :price, :image,
                                   tag_ids: [])
  end

  def set_tags
    @tags = Tag.where.not(course_tags_count: 0).order(course_tags_count: :desc)
  end
end
