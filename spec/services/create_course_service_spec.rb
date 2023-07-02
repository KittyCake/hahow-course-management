require 'rails_helper'

RSpec.describe CreateCourseService do
  let!(:instructor) { create(:instructor) }
  let(:params) do
    {
      name: 'New Course',
      instructor_id: instructor.id,
      chapters: [
        {
          name: 'New Chapter',
          order: 1,
          units: [
            {
              name: 'New Unit',
              description: 'New Unit Description',
              content: 'New Unit Content',
              order: 1
            }
          ]
        }
      ]
    }
  end

  subject { described_class.new(params) }

  describe '#execute' do
    it 'creates a new course' do
      expect { subject.execute }.to change(Course, :count).by(1)
    end

    it 'creates the associated chapters and units' do
      expect { subject.execute }.to change(Chapter, :count).by(1)
      expect { subject.execute }.to change(Unit, :count).by(1)
    end
  end
end