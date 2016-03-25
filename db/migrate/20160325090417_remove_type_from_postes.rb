class RemoveTypeFromPostes < ActiveRecord::Migration
  def change
    remove_column :postes, :type, :string
  end
end
