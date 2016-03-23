class Organisation < ActiveRecord::Base
  has_many :organisation_memberships
  has_many :shops, dependent: :destroy
  has_many :organisation_postes
  has_many :postes, through: :organisation_postes
  has_many :groups
  belongs_to :convention

  validates :name, presence: true, uniqueness: true
end
