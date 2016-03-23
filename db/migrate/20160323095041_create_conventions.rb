class CreateConventions < ActiveRecord::Migration
  def change
    create_table :conventions do |t|
      t.integer :hours_without_pause
      t.integer :max_daily_hours

      t.timestamps null: false
    end
  end
end
