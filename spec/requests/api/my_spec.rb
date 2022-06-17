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
        type: :object,
        properties: {
          token: { type: :string }
        },
        required: ['token']
      }
      response '200', 'blog found' do
        let(:author_id) { 1 }
        let(:token) { { token: "eyJhbGciOiJIUzI1NiJ9.InZpY3RvcnBlcmFsdGFnb21lekBnbWFpbC5jb20i.n3LHMWVU-kyXYdBpRRtIf1vr2bfmCemmwqTDihNrnwE" }}
        run_test!
      end
    end
  end
end
