class RemoveContractTypeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :contract_type, :string
  end
end
