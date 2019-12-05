# == Schema Information
#
# Table name: transactions
#
#  id             :uuid             not null, primary key
#  amount         :decimal(, )
#  processed_at   :datetime
#  state          :string
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  source_user_id :uuid
#  target_user_id :uuid
#
# Indexes
#
#  index_transactions_on_processed_at    (processed_at)
#  index_transactions_on_source_user_id  (source_user_id)
#  index_transactions_on_state           (state)
#  index_transactions_on_target_user_id  (target_user_id)
#  index_transactions_on_type            (type)
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction) { build(:transaction) }
  subject { transaction }

  describe '#callback' do
    it 'add to transaction process queue after created' do
      ActiveJob::Base.queue_adapter = :test

      expect {
        create(:transaction)
      }.to have_enqueued_job
    end
  end


  describe '#validations' do
    it 'amount should greater than 0' do
      invalid_amount = 0
      transaction.amount = invalid_amount
      expect(transaction).not_to be_valid
    end

    it 'currency_type should in the list' do
      invalid_currency_type = 'Litecoin'
      transaction.currency_type = invalid_currency_type
      expect(transaction).not_to be_valid
    end

    it 'target user should not be same with source user' do
      transaction.target_user = transaction.source_user
      expect(transaction).not_to be_valid
    end

    it 'source user wallet should be existed' do
      transaction.currency_type = :bitcoin
      source_user = transaction.source_user
      source_user.bitcoin_wallet_id = nil
      source_user.save!
      puts source_user.attributes
      expect(transaction).not_to be_valid
    end

    it 'target user wallet should be existed' do
      transaction.currency_type = :bitcoin
      target_user = transaction.target_user
      target_user.bitcoin_wallet_id = nil
      target_user.save!
      expect(transaction).not_to be_valid
    end

    it 'source user should have enough balance' do
      transaction.currency_type = :bitcoin
      transaction.amount = 10000
      source_user = transaction.source_user
      source_user.bitcoin_wallet_balance = 100
      source_user.save!
      expect(transaction).not_to be_valid
    end
  end

  describe '.transfer!' do
    it 'move the currency from source user to target user' do
      users = create_pair(:user)
      source_user = users.first
      target_user = users.last
      old_source_user_balance = source_user.bitcoin_wallet_balance
      old_target_user_balance = target_user.bitcoin_wallet_balance
      transaction = create(:transaction,
                           amount: 1000,
                           source_user_id: source_user.id,
                           target_user_id: target_user.id,
                           currency_type: 'bitcoin'
      )
      transaction.transfer!
      source_user.reload
      target_user.reload

      expect(source_user.bitcoin_wallet_balance)
        .to eq old_source_user_balance - transaction.amount

      expect(target_user.bitcoin_wallet_balance)
        .to eq old_target_user_balance + transaction.amount
    end
  end
end
