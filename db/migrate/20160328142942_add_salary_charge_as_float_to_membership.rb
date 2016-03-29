class AddSalaryChargeAsFloatToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :salary_charge, :float
  end
end
