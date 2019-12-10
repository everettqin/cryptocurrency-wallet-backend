class UsersController < APIController

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.search(query_params).order(:name).page page_params
    render json: UserBlueprint.render(@users,
                                      root: :data,
                                      meta: pagination_dict(@users))
  end

  def show
    render json: UserBlueprint.render(@user, root: :data)
  end

  def update
    if @user.update(user_params)
      render json: UserBlueprint.render(@user, root: :data), status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserBlueprint.render(@user, root: :data), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def validate_email
    if User.where(email: params[:email]).exists?
      render json: {validated: false}
    else
      render json: {validated: true}
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,
                                 :description,
                                 :email,
                                 :bitcoin_wallet_id,
                                 :bitcoin_wallet_balance,
                                 :ethereum_wallet_id,
                                 :ethereum_wallet_balance,
                                 :max_transaction_limit)
  end
end
