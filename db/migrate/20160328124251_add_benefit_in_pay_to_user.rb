class AddBenefitInPayToUser < ActiveRecord::Migration
  def change
    add_column :users, :benefit_in_pay, :boolean
  end
end
