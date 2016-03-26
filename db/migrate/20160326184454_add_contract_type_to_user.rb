class AddContractTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :contract_type, :string
  end
end
