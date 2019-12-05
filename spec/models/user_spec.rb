# == Schema Information
#
# Table name: users
#
#  id                      :uuid             not null, primary key
#  bitcoin_wallet_balance  :decimal(, )
#  description             :text
#  email                   :string
#  ethereum_wallet_balance :decimal(, )
#  max_transaction_limit   :decimal(, )
#  name                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  bitcoin_wallet_id       :string
#  ethereum_wallet_id      :string
#
# Indexes
#
#  index_users_on_bitcoin_wallet_id   (bitcoin_wallet_id)
#  index_users_on_email               (email)
#  index_users_on_ethereum_wallet_id  (ethereum_wallet_id)
#  index_users_on_name                (name)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  subject { user }

  describe '#validations' do
    it 'name, max length is 512 characters' do
      valid_name = SecureRandom.hex(250)
      invalid_name = SecureRandom.hex(300)
      user.name = valid_name
      expect(user).to be_valid
      user.save
      user.reload
      expect(user.name).to eq valid_name
      user.name = invalid_name
      expect(user).not_to be_valid
    end

    it 'Description, max length is 1k characters' do
      valid_string = SecureRandom.hex(450)
      invalid_string = SecureRandom.hex(550)
      user.description = valid_string
      expect(user).to be_valid
      user.save
      user.reload
      expect(user.description).to eq valid_string
      user.description = invalid_string
      expect(user).not_to be_valid
    end

    it 'Email, max length is 1k characters' do
      valid_string = SecureRandom.hex(450)
      invalid_string = SecureRandom.hex(550)
      user.email = "#{valid_string}@email.com"
      expect(user).to be_valid
      user.save
      user.reload
      expect(user.email).to eq "#{valid_string}@email.com"
      user.email = "#{invalid_string}@email.com"
      expect(user).not_to be_valid
    end

    it 'Email, be a email' do
      invalid_string = 'test'
      user.email = invalid_string
      expect(user).not_to be_valid
    end
  end

  describe '#identifier' do
    let(:user) { create(:user) }
    it { expect(user.identifier).to eq user.id }
  end
end
