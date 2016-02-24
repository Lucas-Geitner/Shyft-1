class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop

  ROLES = %w(hr_manager line_manager basic_employee)
  validates :role, inclusion: { in: ROLES }
end
