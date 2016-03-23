class Shift < ActiveRecord::Base
  belongs_to :user
  belongs_to :poste
  belongs_to :planning
  belongs_to :shop
  has_many :employees, through: :postes, class_name:'Deal'

  validates :user, :poste, :planning, :starts_at, :ends_at, presence: true

  # SEE COMMENT ON POSTE MODEL
end
