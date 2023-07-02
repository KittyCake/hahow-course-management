require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:instructor) { create(:instructor) }
  let!(:course) { create(:course, instructor_id: instructor.id) }
  let!(:chapter) { create(:chapter, course_id: course.id) }
  let!(:unit) { create(:unit, chapter_id: chapter.id) }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'returns all courses' do
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: course.id }
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:new_course_params) do
        {
          course: {
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
        }
      end

      it 'creates a new course' do
        expect {
          post :create, params: new_course_params
        }.to change(Course, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          course: {
            name: nil,
            instructor_id: instructor.id
          }
        }
      end

      it 'does not create a new course' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Course, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:update_params) do
        {
          id: course.id,
          course: {
            name: 'Updated Course',
            chapters: [
              {
                id: chapter.id,
                name: 'Updated Chapter',
                units: [
                  {
                    id: unit.id,
                    name: 'Updated Unit',
                    description: 'Updated Description',
                    content: 'Updated Content'
                  }
                ]
              }
            ]
          }
        }
      end

      it 'updates the requested course' do
        put :update, params: update_params
        course.reload
        expect(course.name).to eq('Updated Course')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_update_params) do
        {
          id: course.id,
          course: {
            name: nil
          }
        }
      end

      it 'does not update the course' do
        put :update, params: invalid_update_params
        course.reload
        expect(course.name).not_to eq(nil)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested course' do
      expect {
        delete :destroy, params: { id: course.id }
      }.to change(Course, :count).by(-1)
    end
  end
end
