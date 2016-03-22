class AddContractHoursToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :contract_hours, :integer
  end
end
