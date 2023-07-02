class CreateCourseService
  attr_reader :course_params

  def initialize(course_params)
    @course_params = course_params
  end

  def execute
    ActiveRecord::Base.transaction do
      course = Course.create(course_params.except(:chapters))
      course_params[:chapters].each do |chapter_param|
        chapter = course.chapters.create(chapter_param.except(:units))
        chapter_param[:units].each do |unit_param|
          chapter.units.create(unit_param)
        end
      end

      course
    end
  end
end