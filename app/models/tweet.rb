class Tweet < ActiveRecord::Base
  belongs_to :account
  has_many :favoriteships, :dependent => :destroy
  has_many :favorite_users, :through => :favoriteships, :source => :account
end
