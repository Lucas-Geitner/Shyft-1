class Shpposte < ActiveRecord::Base
  belongs_to :shop
  belongs_to :poste

  validates :shop, :poste, presence: true
  validates :poste, uniqueness: { scope: :shop }
  # validates :poste, inclusion: { in: proc { self.shop.organisation.postes } }
end
