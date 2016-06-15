class AddTwitterUserIdToReversalUser < ActiveRecord::Migration
  def change
    add_column :reversal_users, :twitter_user_id, :integer
    add_index :reversal_users, :twitter_user_id, unique: true
  end
end
