class AddStatusToPlannings < ActiveRecord::Migration
  def change
    add_column :plannings, :status, :string, default: false
  end
end
