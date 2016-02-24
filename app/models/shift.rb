class Shift < ActiveRecord::Base
  belongs_to :user
  belongs_to :poste
  belongs_to :planning
end
