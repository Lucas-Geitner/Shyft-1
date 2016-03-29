class AddSalaryChargeToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :salary_charge, :integer
  end
end
