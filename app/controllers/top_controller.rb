class TopController < ApplicationController
  def index
    @account = Account.new
  end
end
