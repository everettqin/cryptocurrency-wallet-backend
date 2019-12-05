class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.search(query_params).page page_params
    render json: UserBlueprint.render(@users,
                                      root: :data,
                                      meta: pagination_dict(@users))
  end

  def show
    render json: UserBlueprint.render(@user, root: :data)
  end

  def update
    @user.update(user_params)
    respond_with @user
  end

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  def destroy
    @user.destroy
    respond_with @user
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
