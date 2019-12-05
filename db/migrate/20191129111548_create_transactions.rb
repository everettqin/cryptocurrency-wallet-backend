class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, id: :uuid do |t|

      t.decimal :amount, null: false, default: 0
      t.string :currency_type, index: true, default: ''
      t.string :state, index: true
      t.uuid :source_user_id, index: true, null: false
      t.uuid :target_user_id, index: true, null: false
      t.datetime :processed_at, index: true
      t.timestamps
    end
  end
end
