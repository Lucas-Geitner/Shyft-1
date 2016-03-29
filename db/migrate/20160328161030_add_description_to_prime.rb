class AddDescriptionToPrime < ActiveRecord::Migration
  def change
    add_column :primes, :description, :string
  end
end
