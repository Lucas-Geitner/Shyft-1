class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :start_date, :string
    add_column :users, :hourly_wage, :float
    add_column :users, :contract_hours, :integer
  end
end
