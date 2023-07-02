require 'rails_helper'

RSpec.describe InstructorsController, type: :controller do
  let!(:instructor) { create(:instructor) }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'returns all instructors' do
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: instructor.id }
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Instructor' do
        expect {
          post :create, params: { instructor: attributes_for(:instructor) }
        }.to change(Instructor, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Instructor' do
        expect {
          post :create, params: { instructor: attributes_for(:instructor, name: nil) }
        }.to change(Instructor, :count).by(0)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_name) { "New Instructor Name" }
      before do
        put :update, params: { id: instructor.id, instructor: { name: new_name } }
      end

      it 'updates the requested instructor' do
        instructor.reload
        expect(instructor.name).to eq(new_name)
      end
    end

    context 'with invalid parameters' do
      before do
        put :update, params: { id: instructor.id, instructor: { name: nil } }
      end

      it 'does not update the instructor' do
        instructor.reload
        expect(instructor.name).to_not eq(nil)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested instructor' do
      expect {
        delete :destroy, params: { id: instructor.id }
      }.to change(Instructor, :count).by(-1)
    end
  end
end
