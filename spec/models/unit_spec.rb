require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:instructor) { create(:instructor) }
  let(:course) { create(:course, instructor_id: instructor.id) }
  let(:chapter) { create(:chapter, course_id: course.id) }
  let(:unit) { create(:unit, chapter_id: chapter.id) }

  subject { unit }

  it { should belong_to(:chapter) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:chapter_id) }
  it { should validate_uniqueness_of(:order).scoped_to(:chapter_id) }
end
