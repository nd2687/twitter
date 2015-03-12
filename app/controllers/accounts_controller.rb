class AccountsController < ApplicationController
  skip_before_action :authenticate_account

  def new
    # @account = Account.new
    # render 'top/index'
  end

  def create
    @account = Account.new(account_params)
    @account.setting_password = true
    if @account.save
      flash[:notice] = "新規登録！"
      session[:current_user_id] = @account.id
      redirect_to :root
    else
      flash[:alert] = "エラー！"
      render action: 'new'
    end
  end

  private
  def account_params
    params.require(:account).permit(
      :nickname, :identify_name,
      :password, :password_confirmation
    )
  end
end
