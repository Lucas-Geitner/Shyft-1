class CreateBenefitInKinds < ActiveRecord::Migration
  def change
    create_table :benefit_in_kinds do |t|
      t.references :organisation, index: true, foreign_key: true
      t.integer :amount

      t.timestamps null: false
    end
  end
end
