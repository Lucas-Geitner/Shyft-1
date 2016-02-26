class Poste < ActiveRecord::Base
  has_many :shifts, dependent: :destroy
  has_many :abilities, dependent: :destroy
end
