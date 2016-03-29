class AddBenefitInKindToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :benefit_in_kind, :integer
  end
end
