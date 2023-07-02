require 'rails_helper'

RSpec.describe UpdateCourseService do
  let!(:instructor) { create(:instructor) }
  let!(:course) { create(:course, instructor: instructor) }
  let!(:chapter) { create(:chapter, course: course) }
  let!(:unit) { create(:unit, chapter: chapter) }
  let(:params) do
    {
      name: 'Updated Course',
      chapters: [
        {
          id: chapter.id,
          name: 'Updated Chapter',
          units: [
            {
              id: unit.id,
              name: 'Updated Unit',
              description: 'Updated Unit Description',
              content: 'Updated Unit Content',
              order: 1
            }
          ]
        }
      ]
    }
  end

  subject { described_class.new(course, params) }

  describe '#execute' do
    it 'updates the course' do
      subject.execute
      expect(course.reload.name).to eq('Updated Course')
    end

    it 'updates the associated chapters and units' do
      subject.execute
      expect(chapter.reload.name).to eq('Updated Chapter')
      expect(unit.reload.name).to eq('Updated Unit')
    end
  end
end