class TransactionsController < ApplicationController

  before_action :set_transaction, only: [:show]

  def index
    @transactions = Transaction.page page_params
    render json: TransactionBlueprint.render(@transactions,
                                             root: :data,
                                             meta: pagination_dict(@transactions))
  end

  def show
    render json: TransactionBlueprint.render(@transaction, root: :data)
  end

  def create
    @transaction = Transaction.create(transaction_params)
    respond_with @transaction
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount,
                                        :source_user_id,
                                        :target_user_id,
                                        :currency_type)
  end
end
