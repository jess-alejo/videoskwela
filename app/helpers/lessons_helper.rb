module LessonsHelper
  def lesson_video_iframe(lesson)
    service = VideoEmbedUrlGenerator.new(lesson.video_url)
    content_tag :figure do
      service.construct_iframe.html_safe
    end
  end
end
