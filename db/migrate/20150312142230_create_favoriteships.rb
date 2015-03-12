class CreateFavoriteships < ActiveRecord::Migration
  def change
    create_table :favoriteships do |t|
      t.references :account, null: false
      t.references :tweet, null: false

      t.timestamps null: false
    end
    add_index :favoriteships, [ :account_id, :tweet_id ], unique: true
  end
end
