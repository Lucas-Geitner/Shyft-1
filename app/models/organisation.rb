class Organisation < ActiveRecord::Base
  has_many :organisation_memberships
  has_many :shops
end
