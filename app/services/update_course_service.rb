class UpdateCourseService
  attr_reader :course, :course_params

  def initialize(course, course_params)
    @course = course
    @course_params = course_params
  end

  def execute
    ActiveRecord::Base.transaction do
      @course.update(course_params.except(:chapters))
      course_params[:chapters].each do |chapter_param|
        chapter = @course.chapters.find_or_initialize_by(id: chapter_param[:id])
        chapter.update(chapter_param.except(:units))
        chapter_param[:units].each do |unit_param|
          unit = chapter.units.find_or_initialize_by(id: unit_param[:id])
          unit.update(unit_param)
        end
      end
    end

    @course
  end
end
