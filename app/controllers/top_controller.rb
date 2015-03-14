class TopController < ApplicationController
  def index
    @account = Account.new
    @accounts = current_user.not_follow_list
    @tweet = Tweet.new
    @timeline = current_user.normal_time_line
  end
end
