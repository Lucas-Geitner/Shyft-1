class Ability < ActiveRecord::Base
  belongs_to :user
  belongs_to :poste

  validates :user, :poste, presence: true
end
