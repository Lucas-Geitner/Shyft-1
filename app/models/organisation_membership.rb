class OrganisationMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation

  validates :user, :organisation, presence: true
end
