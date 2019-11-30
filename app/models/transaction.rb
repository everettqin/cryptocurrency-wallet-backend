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

class Transaction < ApplicationRecord

  # Settings
  alias identifier id

  # Associations
  belongs_to :source_user, class_name: 'User'
  belongs_to :target_user, class_name: 'User'

  # Validations
  validates :amount, presence: true, length: {minimum: 0}

end
