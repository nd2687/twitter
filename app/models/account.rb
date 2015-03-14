class Account < ActiveRecord::Base
  # ツイート
  has_many :tweets, dependent: :destroy

  # フォローしているユーザー
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships

  # フォロワー
  has_many :followerships, :class_name => 'Friendship', :foreign_key => :friend_id, dependent: :destroy
  has_many :followers, :through => :followerships, :source => :account

  # ファボ
  has_many :favoriteships, dependent: :destroy
  has_many :favorite_tweets, :through => :favoriteships, :source => :tweet

  attr_accessor :password, :password_confirmation, :setting_password
  alias_method :setting_password?, :setting_password

  validates :password, presence: true, confirmation: true, on: :create
  validates_uniqueness_of :identify_name, on: :create
  validates :identify_name, format: { with: /\A[a-z0-9]+\z/i, allow_blank: true }

  before_save do
    if setting_password?
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def authenticate(raw_password)
    if password_digest && BCrypt::Password.new(password_digest) == raw_password
      self
    else
      false
    end
  end

  def not_follow_list
    not_display_ids = []
    not_display_ids << friends.map(&:id)
    not_display_ids << self.id
    Account.where.not(id: not_display_ids)
  end

  def normal_time_line
    timeline = []
    timeline << self.tweets
    self.friends.each do |friend|
      timeline << friend.tweets
    end
    timeline.flatten!
    timeline.sort_by{|obj| obj.created_at}.reverse
  end

  def favorited?(timeline_tweet)
    favorite_tweets = []
    favorite_tweets << self.favorite_tweets
    favorite_tweets.flatten!
    favorite_tweets.include?(timeline_tweet)
  end
end
