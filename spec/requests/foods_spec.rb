require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'GET /index' do
    it 'returns a successful response' do
      get foods_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get foods_path
      expect(response).to render_template(:index)
    end

    it 'renders the correct placeholder text in the response body' do
      get foods_path
      expect(response.body).to include('Add Food')
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_food_path
      expect(response).to be_successful
    end
  end

  it 'renders the correct template' do
    get new_food_path
    expect(response).to render_template(:new)
  end

  it 'renders the correct placeholder text in the response body' do
    get new_food_path
    expect(response.body).to include('Add New Food')
  end
end
