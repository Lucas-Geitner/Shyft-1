class AddColorToShppostes < ActiveRecord::Migration
  def change
    add_column :shppostes, :color, :string
  end
end
