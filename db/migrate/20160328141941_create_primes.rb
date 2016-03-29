class CreatePrimes < ActiveRecord::Migration
  def change
    create_table :primes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :shop, index: true, foreign_key: true
      t.integer :amount
      t.datetime :for_month

      t.timestamps null: false
    end
  end
end
