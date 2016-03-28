class AddTransportCostToUser < ActiveRecord::Migration
  def change
    add_column :users, :transport_cost, :integer
  end
end
