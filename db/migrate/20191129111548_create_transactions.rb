class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, id: :uuid do |t|

      t.decimal :amount
      t.string :type, index: true
      t.string :state, index: true
      t.uuid :source_user_id, index: true
      t.uuid :target_user_id, index: true
      t.datetime :processed_at, index: true
      t.timestamps
    end
  end
end
