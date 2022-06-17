require 'swagger_helper'
require 'json'

RSpec.describe 'api/my', type: :request do
  path '/users/{id}/show' do
    get 'Retrieves a list of posts written by a certain user' do
      tags 'Posts'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      # parameter name: :token, in: :body, type: :string
      # parameter name: :pet, in: :body, schema: { type: :string }
      parameter name: :name, in: :body, schema: {
        type: :object,
        properties: {
          one: { type: :integer }
        }
      }


      response '200', 'blog found' do
        schema type: :array

        let(:id) { 4 }
        # let(:pet) { { name: 'Dodo' } }
        # let(:token) { 'token' : 'eyJhbGciOiJIUzI1NiJ9.ImFAYi5jIg.wi8komaIv4rZRRqkHpED0U3VZbyexPL2BgzvskAOwgE' } 
        # let(:body_params) { { token: "eyJhbGciOiJIUzI1NiJ9.ImFAYi5jIg.wi8komaIv4rZRRqkHpED0U3VZbyexPL2BgzvskAOwgE" } }
        let(:name) do
          text = '{"one":1}'
          data = JSON.parse(text)
          data
          # JSON.parse("{ name: 'eyJhbGciOiJIUzI1NiJ9.ImFAYi5jIg.wi8komaIv4rZRRqkHpED0U3VZbyexPL2BgzvskAOwgE' }")
        end
        run_test!
      end

      # response '404', 'blog not found' do
      #   let(:id) { 'invalid' }
      #   run_test!
      # end

      # response '406', 'unsupported accept header' do
      #   let(:'Accept') { 'application/foo' }
      #   run_test!
      # end
    end
  end
end
