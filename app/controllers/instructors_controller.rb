class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :update, :destroy]

  def index
    @instructors = Instructor.all

    render json: @instructors
  end

  def show
    render json: @instructor
  end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      render json: @instructor, status: :created
    else
      render json: @instructor.errors, status: :unprocessable_entity
    end
  end

  def update
    if @instructor.update(instructor_params)
      render json: @instructor
    else
      render json: @instructor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @instructor.destroy
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name)
  end
end
