class TopController < ApplicationController
  def index
    @account = Account.new
    @accounts = Account.all
  end
end
