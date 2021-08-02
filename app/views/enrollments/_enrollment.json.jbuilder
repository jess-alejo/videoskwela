json.extract! enrollment, :id, :course_id, :student_id, :rating, :review, :price, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
