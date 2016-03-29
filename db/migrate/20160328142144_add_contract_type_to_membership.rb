class AddContractTypeToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :contract_type, :string
  end
end
