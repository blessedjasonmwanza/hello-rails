require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
    it 'renders the hello template' do
      get '/'
      expect(response).to render_template('hello')
    end
    it 'renders the hello text' do
      get '/'
      expect(response.body).to include('hello')
    end
  end
end
