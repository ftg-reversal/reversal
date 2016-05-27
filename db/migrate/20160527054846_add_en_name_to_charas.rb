class AddEnNameToCharas < ActiveRecord::Migration
  def change
    add_column :charas, :en_name, :string
  end
end
