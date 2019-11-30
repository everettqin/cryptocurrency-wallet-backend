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

class User < ApplicationRecord

  # Settings
  alias identifier id

  # Validates
  validates :name, presence: true, length: {maximum: 512}
  validates :description, length: {maximum: 1000}
  validates :email, length: {maximum: 1000}, email: true  # accord to maximum specified in RFC 5321 states,  is 256 characters.
  validates :bitcoin_wallet_id, length: {maximum: 512}
  validates :bitcoin_wallet_balance, length: {maximum: 1_000_000_000_000}
  validates :ethereum_wallet_id, length: {maximum: 512}
  validates :ethereum_wallet_balance, length: {maximum: 1_000_000_000_000}

end
