# frozen_string_literal: true

module Courses
  class CourseWizardController < ApplicationController
    include Wicked::Wizard
    before_action :set_course, only: %i[show finish_wizard]
    before_action :set_progress, only: :show

    steps :basic_info, :details

    def show
      render_wizard
    end

    def finish_wizard_path
      course_path(@course)
    end

    private

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def set_progress
      @progress = if wizard_steps.any? && wizard_steps.index(step).present?
                    ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
                  else
                    0
                  end
    end
  end
end
