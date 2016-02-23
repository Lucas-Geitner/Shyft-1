class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.references :user, index: true, foreign_key: true
      t.references :poste, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
