class DeleteTableBenefitInKind < ActiveRecord::Migration
  def change
    drop_table :benefit_in_kinds
  end
end
