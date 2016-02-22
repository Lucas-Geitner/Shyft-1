class CreatePlannings < ActiveRecord::Migration
  def change
    create_table :plannings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :shop, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
