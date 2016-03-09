class RemoveColorFromPostes < ActiveRecord::Migration
  def change
    remove_column :postes, :color, :string
  end
end
