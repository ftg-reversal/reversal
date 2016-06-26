class AddProfileToReversalUser < ActiveRecord::Migration
  def change
    add_column :reversal_users, :use_chara, :integer
    add_column :reversal_users, :rank, :integer
    add_column :reversal_users, :home, :text
    add_column :reversal_users, :bio, :text
    remove_column :twitter_users, :bio
  end
end
