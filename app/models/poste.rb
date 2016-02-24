class Poste < ActiveRecord::Base
  has_many :shifts
  has_many :abilities
end
