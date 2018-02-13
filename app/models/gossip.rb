class Gossip < ApplicationRecord
	belongs_to :creator, class_name: 'Moussaillon', foreign_key: 'moussaillon_id'
end
