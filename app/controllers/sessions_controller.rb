class SessionsController < ApplicationController
  skip_before_action :authenticate_account
  def new
    if current_user
      redirect_to :root
    else
      @account = Account.new
      render 'top/index'
    end
  end

  def create
    if user = UserPasswordAuthenticator.verify(params[:identify_name], params[:password])
      flash.notice = 'ログインしました。'
      session[:current_user_id] = user.id
      redirect_to :root
    else
      flash.now[:alert] = "ログインに失敗しました。"
      render action: 'new'
    end
  end

  def destroy
    # cookies.delete(:current_user_id)
    session.delete(:current_user_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :root
  end
end
