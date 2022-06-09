require 'rails_helper'

RSpec.describe 'ApplicationController', type: :request do
  it 'Renders Not found page' do
    get '/news'
    expect(response).to have_http_status(404)
    expect(response.body).to include("The page you were looking for doesn't exist.")
  end
end
