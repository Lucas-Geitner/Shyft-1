class Membership < ActiveRecord::Base
  ROLES = ["HR Manager", "Line Manager", "Employee"]

  belongs_to :user
  belongs_to :shop

  validates :user, :shop, :role, presence: true
  validates :role, inclusion: { in: ROLES }
end
