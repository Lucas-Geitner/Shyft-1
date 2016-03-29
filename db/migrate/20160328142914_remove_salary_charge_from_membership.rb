class RemoveSalaryChargeFromMembership < ActiveRecord::Migration
  def change
    remove_column :memberships, :salary_charge, :integer
  end
end
