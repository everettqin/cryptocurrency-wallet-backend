class TransactionsProcessJob < ApplicationJob
  queue_as :default

  def perform(transaction)

    if transaction.validates_unequal_user ||
      transaction.validates_source_user_wallet ||
      transaction.validates_target_user_wallet ||
      transaction.validates_enough_balance

      unless transaction.transfer!
        perform_failure(transaction)
        return
      end

      perform_successful(transaction)
    end
  end

  def perform_successful(transaction)
    transaction.process_successful!
  end

  def perform_failure(transaction)
    transaction.process_failure!
  end
end