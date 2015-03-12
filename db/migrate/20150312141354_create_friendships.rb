class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :account, null: false
      t.references :friend, null: false

      t.timestamps null: false
    end
    add_index :friendships, [ :account_id, :friend_id ], unique: true
  end
end
