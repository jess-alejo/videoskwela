class EnrollmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: :certificate
  before_action :set_enrollment, only: %i[show edit update destroy certificate]
  before_action :set_course, only: %i[new create]

  # GET /enrollments or /enrollments.json
  def index
    @ransack_path = enrollments_path
    @q = Enrollment.ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:student, :course))
    authorize @enrollments
  end

  def students
    @ransack_path = students_enrollments_path
    @q = Enrollment.joins(:course).where(courses: { author: current_user }).ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:student, :course))

    render :index
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show; end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
    authorize @enrollment
  end

  # POST /enrollments or /enrollments.json
  def create
    if @course.price > 0
      redirect_to new_course_enrollment_path(@course), alert: 'You can not access paid courses yet'
    else
      current_user.enroll!(@course, @course.price)
      redirect_to course_path(@course), notice: 'You are now enrolled'
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    authorize @enrollment
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def certificate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@enrollment.course.title}, #{@enrollment.student.email}",
               page_size: "Letter",
               template: "enrollments/certificate.html.haml",
               orientation: "Landscape",
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enrollment
    @enrollment = Enrollment.friendly.find(params[:id])
  end

  def set_course
    @course = Course.friendly.find(params[:course_id])
  end

  # Only allow a list of trusted parameters through.
  def enrollment_params
    params.require(:enrollment).permit(:course_id, :student_id, :rating, :review)
  end
end
