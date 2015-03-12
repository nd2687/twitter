class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :nickname, null: false
      t.string :identify_name, null: false
      t.string :password_digest, null: false


      t.timestamps null: false
    end

    add_index :accounts, [ :identify_name ], unique: true
  end
end
