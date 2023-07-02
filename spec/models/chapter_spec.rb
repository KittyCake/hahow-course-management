require 'rails_helper'

RSpec.describe Chapter, type: :model do
  let(:instructor) { create(:instructor) }
  let(:course) { create(:course, instructor_id: instructor.id) }

  let(:chapter) do
    Chapter.create(
      name: "A chapter",
      order: 1,
      course_id: course.id
    )
  end

  subject { chapter }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:order) }
  it { should validate_presence_of(:course_id) }
  it { should belong_to(:course) }
  it { should validate_uniqueness_of(:order).scoped_to(:course_id) }
end
