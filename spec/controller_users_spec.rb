require 'rails_helper'

RSpec.describe 'UsersControllers', type: :request do
  it 'Render List of users and returns correct status' do
    get users_path
    expect(response).to have_http_status(200)
  end
  it 'Render List of users and renders correct template' do
    get users_path
    expect(response).to render_template(:index)
  end
  it 'Render List of users and renders message The Blog application' do
    get users_path
    expect(response.body).to include('The Blog application')
  end

  it 'Render User info and returns correct status' do
    get user_path(id: 1)
    expect(response).to have_http_status(200)
  end
  it 'Render User info and renders correct template' do
    get user_path(id: 1)
    expect(response).to render_template(:show)
  end
  it 'Render User info and render message Bio' do
    get user_path(id: 1)
    expect(response.body).to include('Bio')
  end
end
