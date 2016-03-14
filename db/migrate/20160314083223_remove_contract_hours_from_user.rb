class RemoveContractHoursFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :contract_hours, :integer
  end
end
