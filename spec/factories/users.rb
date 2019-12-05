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

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    description { Faker::Lorem.paragraph }
    bitcoin_wallet_id {SecureRandom.uuid}
    bitcoin_wallet_balance {rand(1000..100_000)}
    ethereum_wallet_id {SecureRandom.uuid}
    ethereum_wallet_balance {rand(1000..100_000)}
  end
end
