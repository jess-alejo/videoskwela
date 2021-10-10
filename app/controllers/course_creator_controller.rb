class CourseCreatorController < ApplicationController
  include Wicked::Wizard
  before_action :set_progress, only: :show

  steps :basic_info, :details

  def show
    render_wizard
  end

  def finish_wizard
    courses_path
  end

  private

  def set_progress
    @progress = if wizard_steps.any? && wizard_steps.index(step).present?
                  ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
                else
                  0
                end
  end
end
