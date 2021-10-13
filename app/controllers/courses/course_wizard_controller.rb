# frozen_string_literal: true

module Courses
  class CourseWizardController < ApplicationController
    include Wicked::Wizard
    before_action :set_course, only: %i[show update finish_wizard]
    before_action :set_progress, only: %i[show update]
    before_action :set_tags, only: %i[show update]

    steps :basic_info, :details, :summary

    def show
      authorize @course, :update?
      render_wizard
    end

    def update
      authorize @course, :update?
      @course.update(course_params)
      render_wizard @course
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

    def set_tags
      case step
      when :basic_info
      when :details
        @tags = Tag.all
      end
    end

    def course_params
      params.require(:course)
            .permit(:title, :description, :short_description, :level, :language, :price, :image,
                    tag_ids: [])
    end
  end
end
