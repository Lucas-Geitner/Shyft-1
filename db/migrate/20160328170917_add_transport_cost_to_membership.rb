class AddTransportCostToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :transport_cost, :float
  end
end
