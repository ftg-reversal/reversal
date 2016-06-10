class AddNumberToEvent < ActiveRecord::Migration
  def change
    add_column :events, :number, :integer, default: 1, null: false
  end
end
