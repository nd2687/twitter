class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_account

  private
  def current_user
    if current_user_id = session[:current_user_id]
    #if current_user_id = cookies.signed[:current_user_id] || session[:current_user_id]
      @current_user = Account.find_by(id: current_user_id)
      session.delete(:current_user_id) unless @current_user
    end
    @current_user
  end
  helper_method :current_user

  def authenticate_account
    unless current_user
      redirect_to [ :new, :session ]
    end
  end
end
