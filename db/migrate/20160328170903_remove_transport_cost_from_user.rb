class RemoveTransportCostFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :transport_cost, :integer
  end
end
