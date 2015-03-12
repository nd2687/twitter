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
      flash.notice = "ログインしました。こんにちは、#{user.nickname}さん(^o^)/"
      session[:current_user_id] = user.id
    else
      flash.alert = "ログインに失敗しました。"
    end
    redirect_to :root
  end

  def destroy
    # cookies.delete(:current_user_id)
    session.delete(:current_user_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :root
  end
end
