class TweetsController < ApplicationController
  def favorite
    Favoriteship.create(:account => current_user, :tweet_id => params[:id] )
    redirect_to :root
  end

  def unfavorite
    @favorited_tweet = current_user.favoriteships.find_by(tweet_id: params[:id])
    if @favorited_tweet.delete
      flash.notice = "お気に入り解除しました。"
    else
      flash.alert = "処理に失敗しました。"
    end
    redirect_to :root
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice] = "ツイートしました"
    else
      flash[:alert] = "エラー！"
    end
    redirect_to :root
  end

  private
  def tweet_params
    params.require(:tweet).permit(
      :body
    )
  end
end
