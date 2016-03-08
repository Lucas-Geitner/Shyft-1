class CreateOrgpostes < ActiveRecord::Migration
  def change
    create_table :orgpostes do |t|
      t.references :organisation, index: true, foreign_key: true
      t.references :poste, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
