class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, index: true
      t.text :description
      t.string :email, index: true
      t.string :bitcoin_wallet_id, index: true
      t.decimal :bitcoin_wallet_balance
      t.string :ethereum_wallet_id, index: true
      t.decimal :ethereum_wallet_balance
      t.decimal :max_transaction_limit

      t.timestamps
    end
  end
end
