class Friendship < ActiveRecord::Base
  belongs_to :account
  belongs_to :friend, :class_name => 'Account', :foreign_key => :friend_id
end
