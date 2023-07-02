class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :update, :destroy]

  def index
    page = params[:page] || 1
    @courses = Course.order(created_at: :desc).page(page).per(10)

    render json: @courses, include: { chapters: { include: :units } }
  end

  def show
    render json: @course, include: { chapters: { include: :units } }
  end

  def create
    @course = CreateCourseService.new(course_params).execute

    if @course.persisted?
      render json: @course, include: { chapters: { include: :units } }, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end

  rescue => e
    render json: e, status: :unprocessable_entity
  end

  def update
    @course = UpdateCourseService.new(@course, course_params).execute

    if @course.errors.empty?
      render json: @course, include: { chapters: { include: :units } }, status: :ok
    else
      render json: @course.errors, status: :unprocessable_entity
    end

  rescue => e
    render json: e, status: :unprocessable_entity
  end

  def destroy
    if @course.destroy
      head :no_content
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course)
          .permit(
            :name,
            :instructor_id,
            chapters: [
              :id,
              :name,
              :order,
              units: [
                :id,
                :name,
                :description,
                :content,
                :order
              ]
            ]
          )
  end

  def find_course
    @course = Course.find(params[:id])
  end
end