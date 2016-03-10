class RenameTableShppostes < ActiveRecord::Migration
  def change
    rename_table :shppostes, :shop_postes
  end
end
