class Shop < ActiveRecord::Base
  belongs_to :organisation
  has_many :memberships
  has_many :shifts
  has_many :plannings
end
