class AddBioToTwitterUser < ActiveRecord::Migration
  def change
    add_column :twitter_users, :bio, :text
  end
end
