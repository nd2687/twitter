class Favoriteship < ActiveRecord::Base
  belongs_to :account
  belongs_to :tweet
end
