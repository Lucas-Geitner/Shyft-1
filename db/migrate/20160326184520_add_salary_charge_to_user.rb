class AddSalaryChargeToUser < ActiveRecord::Migration
  def change
    add_column :users, :salary_charge, :integer
  end
end
