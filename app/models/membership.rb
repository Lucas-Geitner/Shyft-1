class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  ROLES = ["HR Manager", "Line Manager", "Employee"]
  validates :role, inclusion: { in: ROLES }
  belongs_to :hierarchy
end
