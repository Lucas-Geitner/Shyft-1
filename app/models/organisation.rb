class Organisation < ActiveRecord::Base
  has_many :organisation_memberships
  has_many :shops, dependent: :destroy
  has_many :orgpostes
  has_many :postes, through: :orgpostes

  validates :name, presence: true, uniqueness: true
end
