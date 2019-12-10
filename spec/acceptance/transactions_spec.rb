require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Transactions' do

  explanation 'Transactions resource'

  let!(:transactions) { create_list :transaction, 5 }
  let!(:administrator) { create :administrator }

  get '/transactions' do
    example 'Get list of transactions' do
      sign_in(:administrator)

      do_request

      expect(status).to eq 200
      expect(json_data.size).to eq 5

    end
  end

  get 'transactions/:id' do

    context '200' do
      let(:id) { transactions.first.identifier }

      example 'Getting a transaction by id' do
        sign_in(:administrator)

        do_request

        expect(status).to eq(200)
        expect(json_data[:identifier]).to eq id
      end
    end


    include_context '404' do
      let(:id) { 0 }
      let!(:auth) { :administrator }
    end
  end

  post 'transactions' do

    context '201' do

      with_options scope: :transaction, with_example: true do
        parameter :amount, 'The transaction amount', required: true
        parameter :source_user_id, 'The source user id', required: true
        parameter :target_user_id, 'The target user id', required: true
        parameter :currency_type, 'The currency type', required: true
      end

      example 'Create a new transaction' do
        sign_in(:administrator)

        users = create_pair(:user)

        request = {
          transaction: {
            amount: 10000,
            source_user_id: users.first.identifier,
            target_user_id: users.last.identifier,
            currency_type: :bitcoin
          }
        }

        expect {
          do_request(request)
        }.to change { Transaction.count }.by(1)
        expect(status).to eq(201)
      end
    end
  end
end