class ChangeStartDateInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :start_date, :string
    add_column :users, :start_date, :datetime
  end
end
