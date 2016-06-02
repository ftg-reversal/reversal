class AddEntryDeadlineToEvent < ActiveRecord::Migration
  def change
    add_column :events, :entry_deadline, :datetime
  end
end
