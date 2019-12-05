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

FactoryBot.define do
  factory :transaction do
    amount { rand(1..100) }
    currency_type { Transaction.currency_type.values.sample }

    after(:build) do |transaction|
      transaction.source_user = create(:user) if transaction.source_user.nil?
      transaction.target_user = create(:user) if transaction.target_user.nil?
    end
  end
end
