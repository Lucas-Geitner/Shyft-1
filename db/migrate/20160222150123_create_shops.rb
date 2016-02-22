class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.integer :opening_time
      t.integer :closing_time

      t.timestamps null: false
    end
  end
end
