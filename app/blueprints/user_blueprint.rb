class UserBlueprint < BaseBlueprint

  fields :name,
         :description,
         :email,
         :bitcoin_wallet_id,
         :bitcoin_wallet_balance,
         :ethereum_wallet_id,
         :ethereum_wallet_balance,
         :max_transaction_limit

end