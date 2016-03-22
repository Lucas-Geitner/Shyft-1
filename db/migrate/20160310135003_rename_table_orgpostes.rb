class RenameTableOrgpostes < ActiveRecord::Migration
  def change
    rename_table :orgpostes, :organisation_postes
  end
end
