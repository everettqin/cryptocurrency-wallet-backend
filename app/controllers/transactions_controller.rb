class TransactionsController < APIController

  before_action :set_transaction, only: [:show, :history]

  def index
    @transactions = Transaction
    unless params[:user_id].nil?
      @transactions = @transactions.by_user(params[:user_id])
    end
    @transactions = @transactions.order(created_at: :desc).page page_params
    render json: TransactionBlueprint.render(@transactions,
                                             root: :data,
                                             meta: pagination_dict(@transactions))
  end

  def show
    render json: TransactionBlueprint.render(@transaction, root: :data)
  end

  def create
    @transaction = Transaction.new transaction_params

    if @transaction.save
      render json: TransactionBlueprint.render(@transaction, root: :data), status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
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
