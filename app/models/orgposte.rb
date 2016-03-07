class Orgposte < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :poste
end
