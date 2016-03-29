class ChangeBenefitInKindInOrganisation < ActiveRecord::Migration
  def change
    change_column :organisations, :benefit_in_kind, :float
  end
end
