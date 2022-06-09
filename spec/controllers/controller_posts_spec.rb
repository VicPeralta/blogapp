require 'rails_helper'

RSpec.describe 'PostsControllers', type: :request do
  it 'Renders Posts from user 1 and returns correct status' do
    get user_posts_path(user_id: 1)
    expect(response).to have_http_status(200)
  end
  it 'Renders Posts from user 1 and renders correct template' do
    get user_posts_path(user_id: 1)
    expect(response).to render_template(:index)
  end
  it 'Renders Posts from user 1 and renders message Number of post' do
    get user_posts_path(user_id: 1)
    expect(response.body).to include('Number of post')
  end

  it 'Renders Post #2 from user 1 and returns correct status' do
    get user_post_path(user_id: 1, id: 2)
    expect(response).to have_http_status(200)
  end
  it 'Renders Post #2 from user 1 and renders correct template' do
    get user_post_path(user_id: 1, id: 2)
    expect(response).to render_template(:show)
  end
  it 'Renders Post #2 from user 1 and renders message Posts #1' do
    get user_post_path(user_id: 1, id: 2)
    expect(response.body).to include('Posts #2')
  end
end
