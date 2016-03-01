class CreateDeclaredPlannings < ActiveRecord::Migration
  def change
    create_table :declared_plannings do |t|
      t.references :planning, index: true, foreign_key: true
      t.json :shifts

      t.timestamps null: false
    end
  end
end
