class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, index: true
      t.text :description
      t.string :email, index: true
      t.uuid :bitcoin_wallet_id, index: true
      t.decimal :bitcoin_wallet_balance, null: false, default: 0
      t.uuid :ethereum_wallet_id, index: true
      t.decimal :ethereum_wallet_balance, null: false, default: 0
      t.decimal :max_transaction_limit

      t.timestamps
    end
  end
end
