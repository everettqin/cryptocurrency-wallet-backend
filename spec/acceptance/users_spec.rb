require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do

  explanation 'Users resource'

  let!(:users) { create_list :user, 5 }

  get '/users' do
    example 'Get list of users' do
      do_request

      expect(status).to eq 200
      expect(json_data.size).to eq 5

    end
  end

  get 'users/:id' do

    context '200' do
      let(:id) { users.first.identifier }

      example 'Getting a user by id' do
        do_request

        expect(status).to eq(200)
        expect(json_data[:identifier]).to eq id
      end
    end


    include_context '404' do
      let(:id) { 0 }
    end
  end

  post 'users' do

    context '201' do

      with_options scope: :user, with_example: true do
        parameter :name, 'The user name', required: true
        parameter :email, 'The user email', required: true
        parameter :description, 'The user description'
      end

      example 'Create a new user' do

        request = {
          user: {
            name: Faker::Name.name,
            description: Faker::Lorem.sentences,
            email: Faker::Internet.email
          }
        }

        expect {
          do_request(request)
        }.to change { User.count }.by(1)
        expect(status).to eq(201)
      end
    end
  end

  put 'users/:id' do

    context '201' do

      let(:user) { users.first }
      let(:id) { user.identifier }
      let(:bitcoin_wallet_id) { SecureRandom.uuid }

      example 'Update a user' do

        request = {
          user: {
            bitcoin_wallet_id: bitcoin_wallet_id
          }
        }

        expect {
          do_request(request)
          user.reload
        }.to change { user.bitcoin_wallet_id }.to(bitcoin_wallet_id)

        expect(status).to eq(204)
      end
    end
  end
end