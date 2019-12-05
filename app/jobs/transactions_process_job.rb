class TransactionsProcessJob < ApplicationJob
  queue_as :default

  def perform(transaction)

    begin
      transaction.validate_unequal_user
      transaction.validate_existed_source_user_wallet
      transaction.validate_existed_target_user_wallet
      transaction.validate_existed_target_user_wallet
    rescue ActiveRecord::StatementInvalid
      perform_failure(transaction)
      return
    end

    unless transaction.transfer
      perform_failure(transaction)
      return
    end

    perform_successful(transaction)
  end

  def perform_successful(transaction)
    transaction.process_failure
  end

  def perform_failure(transaction)
    transaction.process_successful
  end
end
