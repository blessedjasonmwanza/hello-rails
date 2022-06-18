require 'rails_helper'

RSpec.describe 'Posts', type: :request
describe 'GET /users/:id/posts' do
  it 'returns http success' do
    get '/users/1/posts'
    expect(response).to have_http_status(:success)
  end
  it 'renders the index template' do
    get '/users/1/posts'
    expect(response).to render_template('index')
  end
end
describe 'GET /users/:id/posts/:id' do
  it 'returns http success' do
    get '/users/1/posts/1'
    expect(response).to have_http_status(:success)
  end
  it 'renders the show template' do
    get '/users/1/posts/1'
    expect(response).to render_template('show')
  end
end
