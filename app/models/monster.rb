class Monster < ActiveRecord::Base
  belongs_to :evolution_from, class: Monster
end
