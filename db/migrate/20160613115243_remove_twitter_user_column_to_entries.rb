class RemoveTwitterUserColumnToEntries < ActiveRecord::Migration
  def change
    remove_reference :entries, :twitter_user, index: true, foreign_key: true
  end
end
