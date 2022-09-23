require 'swagger_helper'
require 'json'

RSpec.describe 'Testint API', type: :request do
  path '/users/{author_id}/show' do
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
        # Token victorperaltagomez@gmail.com
        # eyJhbGciOiJIUzI1NiJ9.InZpY3RvcnBlcmFsdGFnb21lekBnbWFpbC5jb20i.n3LHMWVU-kyXYdBpRRtIf1vr2bfmCemmwqTDihNrnwE
        let(:token) do
          { token: 'eyJhbGciOiJIUzI1NiJ9.ImJlaG5hbS5hZ2hhYWxpQHlhaG9vLmNvbSI.' \
                   'EMSaznbIWMcFfu5VfvmTtfMQ39zWqgGM31UG36jIYEo' }
        end
        run_test!
      end
    end
  end
end
