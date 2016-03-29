class RemoveSalaryChargeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :salary_charge, :integer
  end
end
