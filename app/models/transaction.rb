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

  ## modules
  include AASM
  extend Enumerize

  ## Settings
  alias identifier id
  has_paper_trail
  enumerize :currency_type, in: [:bitcoin, :ethereum]

  ## Associations
  belongs_to :source_user, class_name: 'User'
  belongs_to :target_user, class_name: 'User'

  ## Validations
  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :currency_type, presence: true
  validate :validates_unequal_user,
           :validates_source_user_wallet,
           :validates_target_user_wallet,
           :validates_enough_balance,
           unless: -> { source_user.nil? || target_user.nil? || amount.nil? || currency_type.nil? }

  ## Callbacks
  after_create :process_begin!

  ## Scopes
  scope :by_user, ->(user_id) { where(source_user_id: user_id).or(where(target_user_id: user_id)) }

  ## state machine
  aasm column: :state do
    state :awaiting, initial: true
    state :processing, :processed, :failed

    event :process_begin do
      transitions from: :awaiting, to: :processing, after: :add_to_process_queue
    end

    event :process_successful do
      transitions from: :processing, to: :processed, after: :add_processed_at!
    end

    event :process_failure do
      transitions from: :processing, to: :failed
    end
  end

  def transfer!
    source_user["#{currency_type}_wallet_balance"] =
      source_user["#{currency_type}_wallet_balance"] - amount
    target_user["#{currency_type}_wallet_balance"] =
      target_user["#{currency_type}_wallet_balance"] + amount

    ActiveRecord::Base.transaction do
      begin
        source_user.save!
        target_user.save!
        return true
      rescue ActiveRecord::StatementInvalid
        return false
      end
    end
  end

  def add_processed_at!
    update_attribute :processed_at, Time.now
  end

  def validates_unequal_user
    if source_user_id == target_user_id
      errors.add(:target_user_id, "can't be same with source user id")
    end
    true
  end

  def validates_source_user_wallet
    source_user_wallet = source_user.attributes["#{currency_type}_wallet_id"]
    if source_user_wallet.nil?
      errors.add(:source_user, "have not #{currency_type} wallet")
    end
    true
  end

  def validates_target_user_wallet
    target_user_wallet = target_user.attributes["#{currency_type}_wallet_id"]
    if target_user_wallet.nil?
      errors.add(:target_user, "have not #{currency_type} wallet")
    end
    true
  end

  def validates_enough_balance
    current_balance = source_user.attributes["#{currency_type}_wallet_balance"]
    if amount > current_balance
      errors.add(:amount,
                 "can't be greater than current #{currency_type} wallet balance")
    end
    true
  end

  private

  def add_to_process_queue
    TransactionsProcessJob.perform_later self
  end
end
