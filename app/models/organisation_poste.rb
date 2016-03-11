class OrganisationPoste < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :poste

  validates :organisation, :poste, presence: true
  validates :poste, uniqueness: { scope: :organisation }
end
