class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :username
      t.string :name
      t.string :email
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.integer :roles_mask

      t.timestamps
    end
  end
end
