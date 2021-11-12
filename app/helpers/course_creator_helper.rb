# frozen_string_literal: true

module CourseCreatorHelper
  def wicked_progress(step)
    border = if current_step?(step)
               "border-warning"
             elsif past_step?(step)
               "border-success"
             else
               "border-secondary"
             end

    content_tag(:div, class: "steps bg-white border border-4 #{border}") do
      icon = if past_step?(step)
               content_tag(:span, class: "text-success") do
                 content_tag(:i, nil, class: "fa fa-check")
               end
             else
               content_tag(:div, class: "small text-muted") do
                 wizard_steps.index(step).next.to_s
               end
             end

      icon.concat(content_tag(:div, class: "step-label") do
        content_tag(:div, class: "small text-muted") do
          link_to(step.to_s.titleize, wizard_path(step), class: "text-primary")
        end
      end)
    end
  end

  def wicked_progress_line(step)
    return unless wizard_steps.index(step).next < wizard_steps.count

    bg = previous_step?(step) ? "bg-success" : "bg-secondary"
    content_tag(:span, nil, class: "line #{bg}")
  end

  def previous_path(step, course)
    wizard_steps.index(step) == 0 ? course_path(course) : previous_wizard_path
  end
end
