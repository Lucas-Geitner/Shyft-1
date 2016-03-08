class CreateShppostes < ActiveRecord::Migration
  def change
    create_table :shppostes do |t|
      t.references :shop, index: true, foreign_key: true
      t.references :poste, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
