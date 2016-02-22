class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :poste, index: true, foreign_key: true
      t.references :planning, index: true, foreign_key: true
      t.references :shop, index: true, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps null: false
    end
  end
end
