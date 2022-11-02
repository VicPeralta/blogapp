require 'swagger_helper'
require 'json'

RSpec.describe 'Testing API', type: :request do
  before(:all) do
    @user = User.create(name: 'Victor', photo: '', bio: 'bio',
                        email: 'victorperaltagomez@gmail.com', password: '121212')
    @user.confirm
  end

  after(:all) do
    @user.destroy
  end
  path '/api/users/{author_id}/show' do
    post 'Retrieves a list of posts written by a certain user' do
      tags 'Posts'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :author_id, in: :path, type: :string
      parameter name: :token, in: :body, schema: {
        type: :object, properties: { token: { type: :string } }, required: ['token']
      }
      response '200', 'blog found' do
        schema type: :array,
               properties: {
                 author_id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string },
                 commentsCounter: { type: :integer },
                 likesCounter: { type: :integer },
                 created_at: { type: :date },
                 updated_at: { type: :date },
                 id: { type: :integer }
               },
               required: ['id']

        let(:author_id) { 1 }
        let(:token) do
          { token: @user.token }
        end
        run_test!
      end
    end
  end
end
