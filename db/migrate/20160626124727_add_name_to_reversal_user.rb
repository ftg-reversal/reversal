class AddNameToReversalUser < ActiveRecord::Migration
  def change
    add_column :reversal_users, :name, :string
  end
end
