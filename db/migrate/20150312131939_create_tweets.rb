class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :body, null: false
      t.references :account, null: false

      t.timestamps null: false
    end
  end
end
